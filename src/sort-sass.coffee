Line = require './line'
order = require './order'

splitOnLines = (sass) ->
  sass.split('\n').map (str) -> new Line str

generateTrees = (lines) ->
  prevLine = null
  lines.reduce (roots, line) ->
    parent = findParentFor prevLine, line
    if parent?
      parent.addChild line
    else
      roots.push line
    prevLine = line unless line.isUnimportant()
    roots
  , []

findParentFor = (parent, line) ->
  condition = if line.isUnimportant()
    -> parent.isSortable()
  else
    -> parent.indent >= line.indent
  parent = parent.parent while parent? and condition()
  parent

sortTrees = (roots) ->
  sortTree root for root in roots

sortTree = (root) ->
  return unless root.shouldSortChildren()

  sortableChildren = []
  index = 0
  while index < root.children.length
    child = root.children[index]
    index++
    continue if child.isUnimportant()
    break unless child.isSortable()
    root.children.splice index - 1, 1
    index--
    sortableChildren.push child

  root.children.forEach (child) ->
    sortTree child
    true

  root.children.unshift sortChildren(sortableChildren)...

generateLines = (roots, lines = []) ->
  roots.reduce (result, root) ->
    result.push "#{' '.repeat(root.indent)}#{root.str}"
    generateLines root.children, result
    result
  , lines

sortChildren = (children) ->
  children.sort (child1, child2) ->
    return -1 if child1.type == 'include' and child2.type != 'include'
    return 1 if child1.type != 'include' and child2.type == 'include'
    return 0 if child1.type == 'include' and child2.type == 'include'

    pos1 = order.indexOf child1.propertyName()
    pos2 = order.indexOf child2.propertyName()

    return pos1 - pos2 if pos1 != -1 and pos2 != -1
    return -1 if pos2 == -1
    return 1 if pos1 == -1
    0

sortSass = (sass) ->
  lines = splitOnLines sass
  roots = generateTrees lines
  sortTrees roots
  generateLines(roots).join("\n")

module.exports = sortSass

class Line
  types: [
    'empty'
    'comment'
    'import'
    'function'
    'control'
    'mixin'
    'variable'
    'media'
    'include'
    'keyframes'
    'selector'
    'property'
  ]
  unimportantTypes: [
    'empty'
    'comment'
  ]
  sortableTypes: [
    'include'
    'property'
  ]
  sorterTypes: [
    'mixin'
    'media'
    'selector'
  ]

  constructor: (@str) ->
    @indent = /^\s*/.exec(@str)[0].length
    @str = @str.trim()
    @type = @determineType()
    @children = []

  addChild: (line) ->
    line.parent = @
    @children.push line

  propertyName: ->
    return unless @type == 'property'
    @str.split(':')[0]

  isUnimportant: ->
    @unimportantTypes.indexOf(@type) != -1

  isSortable: ->
    @sortableTypes.indexOf(@type) != -1

  shouldSortChildren: ->
    @sorterTypes.indexOf(@type) != -1

  determineType: ->
    switch
      when @str.length == 0 then 'empty'
      when @str.startsWith '//' then 'comment'
      when @str.startsWith '@import' then 'import'
      when @str.startsWith '@function' then 'function'
      when /^@(if|for|each|while)/.test @str then 'control'
      when /^(@mixin|=)/.test @str then 'mixin'
      when @str.startsWith '$' then 'variable'
      when @str.startsWith '@media' then 'media'
      when /^(@extend|\+)/.test @str then 'include'
      when @str.startsWith '@keyframes' then 'keyframes'
      when /^(\.|#|\w|&|::|\*)/.test(@str) and not @str.includes(': ') then 'selector'
      when /^([a-z\-]+):/.test @str then 'property'
      else 'something'

module.exports = Line

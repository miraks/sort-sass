_ = require 'lodash'

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
      when _.startsWith @str, '//' then 'comment'
      when _.startsWith @str, '@import' then 'import'
      when _.startsWith @str, '@function' then 'function'
      when /^@(if|for|each|while)/.test @str then 'control'
      when /^(@mixin|=)/.test @str then 'mixin'
      when _.startsWith @str, '$' then 'variable'
      when _.startsWith @str, '@media' then 'media'
      when /^(@extend|\+)/.test @str then 'include'
      when _.startsWith @str, '@keyframes' then 'keyframes'
      when /^(\.|#|\w|&|::|\*)/.test(@str) and not _.includes(@str, ': ') then 'selector'
      when /^([a-z\-]+):/.test @str then 'property'
      else 'something'

module.exports = Line

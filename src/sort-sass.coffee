Sorter = require './sorter'

sortSass = (sass, opts) ->
  sorter = new Sorter(sass, opts)
  sorter.sort()

module.exports = sortSass

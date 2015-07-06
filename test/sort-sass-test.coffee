_ = require 'lodash'
fs = require 'fs'
path = require 'path'
{expect} = require 'chai'
sortSass = require '../src/sort-sass'

fixturePath = (name) ->
  path.join __dirname, 'fixtures', name

describe '#sortSass', ->
  samples = fs.readdirSync(fixturePath('')).filter (file) ->
    _.startsWith file, 'sample'

  samples.forEach (sample) ->
    it "correctly sorts #{sample}", (done) ->
      fs.readFile fixturePath(sample), (err, sass) ->
        throw err if err?
        fs.readFile fixturePath(sample.replace('sample', 'result')), (err, expectedSass) ->
          throw err if err?
          expect(sortSass(sass)).to.eq(expectedSass.toString())
          done()

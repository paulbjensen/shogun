mocha         = require 'mocha'
{spawn, exec} = require 'child_process'
{print}       = require 'util'

task "test", "runs the unit tests", ->
  files = []
  Mocha = new mocha
  for file in files
    Mocha.addFile "test/#{file.replace('.coffee','_test.coffee')}"
  Mocha.run()

task "cucumber", "runs the integration tests", ->
  exec "cucumber.js", (err, stdout, stderr) ->
    print stdout if stdout?
    print stderr if stderr?
mocha         = require 'mocha'
{spawn, exec} = require 'child_process'
{print}       = require 'util'

task "test", "runs the unit tests", ->
  process.env["SS_ENV"]   = "test"
  global.ss               = require "socketstream"
  global.config           = require "#{__dirname}/server/config.coffee"
  files                   = ['server/models/user.coffee']
  Mocha = new mocha
  for file in files
    Mocha.addFile "test/#{file.replace('.coffee','_test.coffee')}"
  Mocha.run ->
    process.exit 0

task "cucumber", "runs the integration tests", ->
  exec "cucumber.js", (err, stdout, stderr) ->
    print stdout if stdout?
    print stderr if stderr?
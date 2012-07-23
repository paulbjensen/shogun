assert = require 'assert'
require "#{__dirname}/../../../server/db.coffee"

# TODO - figure out way to not have to manually require the user and project models
require "#{__dirname}/../../../server/models/user.coffee"
require "#{__dirname}/../../../server/models/project.coffee"

describe User, ->

  afterEach (done) ->
    User.remove {}, (err) ->
      done()

  describe "create a new user", ->

    it "should encrypt the user's password", (done) ->
      username  =   "paulbjensen"
      email     =   "paulbjensen@gmail.com"
      password  =   "123456"
      user = new User {username, email, password}
      user.save (err, doc) ->
        assert !doc.password?
        assert doc.passwordHash?
        assert doc.passwordSalt?
        done()

  describe "delete a user", ->

    it "should remove all of the user's projects", (done) ->
      username  =   "paulbjensen"
      email     =   "paulbjensen@gmail.com"
      password  =   "123456"
      user = new User {username, email, password}
      user.save (err, doc) ->
        project = new Project {name: "Your project", userId: doc._id}
        project.save (err, savedProject) ->
          user.remove (err) ->
            Project.find {}, (err, projects) ->
              assert.equal 0, projects.length
              done()
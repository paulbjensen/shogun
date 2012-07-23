http            = require 'http'
global.ss       = require 'socketstream'
global.config   = require './server/config.coffee'
db              = require './server/db.coffee'

# Controllers, a way of sharing common logic between RPC and REST APIs
global.userController     = require "#{__dirname}/server/controllers/user.coffee"
global.projectController  = require "#{__dirname}/server/controllers/project.coffee"

# Define a single-page client
ss.client.define 'main',
  view: 'app.jade'
  css:  ['libs', 'app.styl']
  code: ['libs', 'app']
  tmpl: '*'

# Serve this client on the root URL
ss.http.route '/', (req, res) ->
  res.serveClient 'main'

# Code Formatters
ss.client.formatters.add require library for library in ['ss-coffee', 'ss-jade', 'ss-stylus']

# Use server-side compiled Hogan (Mustache) templates. Others engines available
ss.client.templateEngine.use require 'ss-hogan'

# Minimize and pack assets if you type: SS_ENV=production node app.js
ss.client.packAssets() if ss.env is 'production'

# Start web server
server = http.Server ss.http.middleware
server.listen config[ss.env].port

# Start SocketStream
ss.start server
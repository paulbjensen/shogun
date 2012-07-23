fs                = require 'fs'
global.mongoose   = require 'mongoose'
mongoose.connect "mongodb://#{config[ss.env].db}"

global.Schema   = mongoose.Schema
global.ObjectId = Schema.ObjectId

fs.readdir "#{__dirname}/models", (err, files) ->
  require "#{__dirname}/models/#{file}" for file in files
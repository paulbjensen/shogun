bcrypt  = require 'bcrypt'

toLower = (value) -> value.toLowerCase()

hashPassword = (password, cb) ->
  bcrypt.genSalt 10, (err, salt) -> 
    bcrypt.hash password, salt, (err, hash) -> 
      cb hash: hash, salt: salt

global.Users = new Schema
  username            : type: String, set: toLower
  email               : type: String, set: toLower
  password            : String
  passwordHash        : String
  passwordSalt        : String
  createdAt           : type: Date, default: Date.now
  updatedAt           : type: Date, default: Date.now

# Encrypt the password
Users.pre 'save', (next) ->
  if @isNew
    hashPassword @password, (hashedPassword) =>
      @passwordHash = hashedPassword.hash
      @passwordSalt = hashedPassword.salt
      @password     = undefined
      next()
  else
    next()

# Remove all of the user's projects [tidy]
Users.pre 'remove', (next) ->
  Project.find {userId: @_id}, (err, projects) ->
    for project in projects
      project.remove (err) ->
        next new Error(err) if err?
        next() if projects.indexOf(project) is projects.length-1

global.User = mongoose.model 'User', Users
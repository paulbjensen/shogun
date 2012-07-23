module.exports =

  create: (data, cb) ->
    new User(data).save (err, doc) ->
      if !err
        # TODO - restrict the fields so that the password hash and salt do not end up being transported.
        cb status: 'success', user: doc
      else
        cb status: 'failure', reason: err
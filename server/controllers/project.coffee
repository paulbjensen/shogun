module.exports =

  create: (data, cb) ->
    new Project(data).save (err, doc) ->
      if !err
        cb status: 'success', project: doc
      else
        cb status: 'failure', reason: err
exports.actions = (req,res,ss) ->
  
  create: (data) ->
    userController.create data, (response) -> 
      res response

  
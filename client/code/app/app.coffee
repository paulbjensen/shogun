# Thoughts - maybe the validation should be handled by a separate module,
# and each form has it's own validator instance. That way, validation is 
# separated from the UI a bit more.

# Or, you share the validation between the model and the view.
#
# So that the view validates the 

serializeFormData = (selector, callback) ->
    data = {}
    $.each jQuery(selector).serializeArray(), (index,key) -> data[key.name] = key.value
    callback data

module.exports =

  init: ->

    # Define a page area called content, and setup 2 states it can have: 'homepage' and 'content' 
    contentState = new StateManager '#content'
    contentState.addState 'homepage', -> contentState.html ss.tmpl.homepage.r()
    contentState.addState 'project', (data) -> contentState.html ss.tmpl["project"].render data

    contentState.setState 'homepage'

    # # validate the field
    # $('form#signup input').on 'blur', ->
    #   validate @.attr('name'), @.val(), (result) =>
    #     if result.status isnt 'valid'
    #       # apply error styling
    #       # set old-placeholder attribute
    #       # set placeholder attribute to error message
    #       # clear the value

    # This event binding should happen once, and only when the homepage state is in view
    $("form#signup").on 'submit', ->
      $(@).find('button').attr 'disabled', 'disabled'
      serializeFormData @, (data) ->
        # validate it
        ss.rpc 'user.create', data, (response) ->
          if response.status is 'success'
            # # TODO - scope this in the RPC, so that people can't hack which user the project is created for.
            ss.rpc 'project.create', {name: "Your project", userId: response.user._id}, (response2) ->
              contentState.setState 'project', {username: response.user.username, name: response2.project.name}
      false




  # validate: (field, value, result) ->
  #   # what are we validating? uniqueness, length, format?
  #   # Where is this configured?


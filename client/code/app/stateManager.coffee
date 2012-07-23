class window.StateManager
  constructor: (@domId) ->
    @currentState = null
    @states = {}
  
  addState: (domClass, render) ->
    @states[domClass] = render

  setState: (state, data=null) ->
    if @currentState?
      jQuery("#{@domId} .#{@currentState}").fadeOut 'slow', =>
        @states[state] data
        jQuery("#{@domId} .#{state}").hide().fadeIn 'slow'
    else
      @states[state] data
      jQuery("#{@domId} .#{state}").hide().fadeIn 'slow'

  html: (newHtml) ->
    jQuery(@domId).html(newHtml)
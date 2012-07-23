World = (callback) ->
  process.env["SS_ENV"] = "cucumber"

  config                = require '../../server/config.coffee'

  selenium              = require 'selenium-launcher'
  soda                  = require 'soda'
  app                   = require '../../app.coffee'

  selenium (err, selenium) =>

    @browser = soda.createClient
      host:     selenium.host
      port:     selenium.port
      url:      "http://localhost:#{config[process.env['SS_ENV']].port}"
      browser:  "firefox"

    callback {@browser}
    process.on 'exit', -> selenium.kill()

exports.World = World

# Available browser options
#
# *firefox
# *mock
# *firefoxproxy
# *pifirefox
# *chrome
# *iexploreproxy
# *iexplore
# *firefox3
# *safariproxy
# *googlechrome
# *konqueror
# *firefox2
# *safari
# *piiexplore
# *firefoxchrome
# *opera
# *webdriver
# *iehta
# *custom
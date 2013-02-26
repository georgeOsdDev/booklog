"use strict"
global = @
requirement = [
  "underscore",
  "jquery",
  "backbone",
  "config",
  "util/jsonp"
  "views/shelf"
]

require requirement,(_,jquery,Backbone,config,JSONP,Shelf) ->
  class App
    constructor: ->
      @name = "Booklog"
      @version = "1.0.0"

    getName: ->
      @name

    getVersion: ->
      @version

    chkDependencies:->
      if _ then console.log "underscore #{_.VERSION} is ready"
      if $ then console.log "jquery #{$.prototype.jquery} is ready"
      if Backbone then console.log "backbone #{Backbone.VERSION} is ready"
      if config then console.log "config is ready",JSON.stringify(config)
      return _ and $ and Backbone and config

  app = new App()
  app.shelf = new Shelf()

  $ ->
    navbar_top = $("#navbar").offset().top
    scroll = 0

    $(document).scroll ->
      scroll = $(@).scrollTop()
      if navbar_top <= scroll
        $("#navbar").addClass "follow_scroll"
      else if navbar_top >= scroll
        $("#navbar").removeClass "follow_scroll"

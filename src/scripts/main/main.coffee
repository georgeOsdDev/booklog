"use strict"
global = @
requirement = [
  "underscore",
  "jquery",
  "jquery.lazyload",
  "backbone",
  "config",
  "util/jsonp"
  "views/shelf"
]

require requirement,(_,jquery,lazy,Backbone,config,JSONP,Shelf) ->
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

    if navigator.userAgent.match(/(iPhone|iPod|iPad|Mobile|Android)/g) then $("img.lazy").lazyload()
    navbar_top = $("#navbar").offset().top
    scroll = 0

    $(document).scroll ->
      scroll = $(@).scrollTop()
      if navbar_top <= scroll
        $("#navbar").addClass "follow_scroll"
      else if navbar_top >= scroll
        $("#navbar").removeClass "follow_scroll"

    status =
      rank_5:"show"
      rank_4:"show"
      rank_3:"show"
      rank_2:"show"
      rank_1:"show"

    $("#toggle_btn").children().on "click", ->
      target = $(@).data("target")
      if status[target] is "show"
        $(".#{target}").addClass("hide").removeClass("item show")
        status[target] = "hide"
        $(@).removeClass("press")
      else
        $(".#{target}").addClass("item show").removeClass("hide")
        status[target] = "show"
        $(@).addClass("press")

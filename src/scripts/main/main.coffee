"use strict"
global = @
require ["underscore","jquery","backbone","config","util/jsonp"],(_,jquery,Backbone,config,JSONP) ->
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

  app = new App

  app.CONST =
    baseUrl:"http://api.booklog.jp/json"

  app.Book = Backbone.Model.extend
    defaults:
      id: ""
      asin: ""
      title: ""
      author: ""
      image: ""

  app.Books = Backbone.Collection.extend
    model:app.Book

    rank:"5"

    getUrl: ->
      "#{app.CONST.baseUrl}/#{config.bookloguser}?category=0&count=100&rank=#{@rank}"

    initialize:->
      @on "next", ->
        if @rank > 2
          @rank -= 1
          @fetch()

    fetch:->
      self = @
      jsonp = new JSONP(global)
      jsonp.request @getUrl(),(data) ->
        _.each data.books, (book,idx) ->
          if book.asin
            book["rank"] = self.rank
            self.add book
          else
            self.trigger "end"
        self.trigger "next"

  app.ShelfView = Backbone.View.extend
    el:$("#shelf")

    initialize:->
      self = @
      _.bindAll @, "render","compile","display"
      @collection = new app.Books()
      @collection.on "add", (book) ->
        self.render(book)
      @collection.on "end", ->
        self.display()
      @collection.fetch()

    render: (book)->
      $(@el).append @compile(book)

    compile: (book)->
      litagFmt = """
                <div class='hide item rank_<%= book.get("rank") %>'>
                  <p><span class="rating star_<%= book.get("rank") %>"></span></p>
                  <div class="thumbnail"><a href='http://www.amazon.co.jp/gp/product/<%= book.get('asin') %>/ref=as_li_ss_il?ie=UTF8&camp=247&creative=7399&creativeASIN=<%= book.get('asin') %>&linkCode=as2&tag=<%= config.amazonuser %>-22' target='_blank'>
                    <img src='<%= book.get('image').replace('SL75','SL180') || 'noimage.png'%>' alt='<%= book.get('title') %>'>
                  </a></div>
                  <p class="author"><%= book.get('author') %></p>
                  <p class="title"><%= book.get('title').replace(/[^ -~｡-ﾟ]/g,"  ").length > 80 ? book.get('title').substr(0,40) + "..." : book.get('title') %></p>
                  <p class="buttons"><button class='btn booklog'>booklog</button><button class='btn amazon'>amazon</button></p>
                </div>"""

      _.template litagFmt, {book:book,config:config}

    display: ->
      #TODO Lazy image loading.
      $(@el).children('.item').removeClass('hide')

  shelfView = new app.ShelfView()

  $ ->
    navbar_top = $("#navbar").offset().top
    scroll = 0

    $(document).scroll ->
      scroll = $(@).scrollTop()
      if navbar_top <= scroll
        $("#navbar").addClass "follow_scroll"
      else if navbar_top >= scroll
        $("#navbar").removeClass "follow_scroll"

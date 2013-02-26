"use strict"
define ["underscore","backbone","config","util/jsonp","models/book"],(_,Backbone,config,JSONP,Book) ->
  Books = Backbone.Collection.extend
    model:Book

    rank:"5"

    getUrl: ->
      "http://api.booklog.jp/json/#{config.bookloguser}?category=0&count=100&rank=#{@rank}"

    initialize:->
      self = @
      @on "next", ->
        if @rank > 1
          @rank -= 1
          @fetch()
        else
          self.trigger "end"

    fetch:->
      self = @
      jsonp = new JSONP(global)
      jsonp.request @getUrl(),(data) ->
        _.each data.books, (book,idx) ->
          if book.asin
            book["rank"] = self.rank
            self.add book
        self.trigger "next"
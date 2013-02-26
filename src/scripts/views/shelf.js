"use strict"
define ->
  Shelf = Backbone.View.extend
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
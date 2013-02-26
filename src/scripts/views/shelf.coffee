"use strict"
define ["underscore","backbone","config","collections/books"],(_,Backbone,config,Books) ->
  Shelf = Backbone.View.extend
    el:$("#shelf")

    initialize:->
      self = @
      _.bindAll @, "render","compile","display"
      @collection = new Books()
      # @collection.on "add", (book) ->
      #   self.render(book)
      @collection.on "end", ->
        self.display()
      @collection.fetch()

    render: ->
      $(@el).append @compile @collection

    compile: (books)->
      litagFmt = """
                <% _.each(books.models, function(book,idx){ %>
                <div class='hide item rank_<%= book.get("rank") %>'>
                  <p><span class="rating star_<%= book.get("rank") %>"></span></p>
                  <div class="thumbnail"><a href='http://www.amazon.co.jp/gp/product/<%= book.get('asin') %>/ref=as_li_ss_il?ie=UTF8&camp=247&creative=7399&creativeASIN=<%= book.get('asin') %>&linkCode=as2&tag=<%= config.amazonuser %>-22' target='_blank'>
                    <img class='lazy' src='<%= book.get('image').replace('SL75','SL180') || 'img/noimage.gif' %>' alt='<%= book.get('title') %>'>
                  </a></div>
                  <p class="author"><%= book.get('author') %></p>
                  <p class="title"><%= book.get('title').replace(/[^ -~｡-ﾟ]/g,"  ").length > 80 ? book.get('title').substr(0,40) + "..." : book.get('title') %></p>
                  <p class="buttons">
                    <a href='http://booklog.jp/users/georgeosd/archives/1/<%= book.get('asin') %>' target='_blank'><button class='btn booklog'>Booklog</button></a>
                    <a href='http://www.amazon.co.jp/gp/product/<%= book.get('asin') %>/ref=as_li_ss_il?ie=UTF8&camp=247&creative=7399&creativeASIN=<%= book.get('asin') %>&linkCode=as2&tag=<%= config.amazonuser %>-22' target='_blank'><button class='btn amazon'>Amazon</button></a>
                  </p>
                </div>
                <% }); %>"""

      _.template litagFmt, {books:books,config:config}

    display: ->
      @render()
      #TODO Lazy image loading.
      $(@el).children('.item').removeClass('hide')

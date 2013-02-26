"use strict";
define(["underscore", "backbone", "config", "collections/books.min"], function(_, Backbone, config, Books) {
  var Shelf;
  return Shelf = Backbone.View.extend({
    el: $("#shelf"),
    initialize: function() {
      var self;
      self = this;
      _.bindAll(this, "render", "compile", "display");
      this.collection = new Books();
      this.collection.on("end", function() {
        return self.display();
      });
      return this.collection.fetch();
    },
    render: function() {
      return $(this.el).append(this.compile(this.collection));
    },
    compile: function(books) {
      var litagFmt;
      litagFmt = "<% _.each(books.models, function(book,idx){ %>\n<div class='hide item rank_<%= book.get(\"rank\") %>'>\n  <p><span class=\"rating star_<%= book.get(\"rank\") %>\"></span></p>\n  <div class=\"thumbnail\"><a href='http://www.amazon.co.jp/gp/product/<%= book.get('asin') %>/ref=as_li_ss_il?ie=UTF8&camp=247&creative=7399&creativeASIN=<%= book.get('asin') %>&linkCode=as2&tag=<%= config.amazonuser %>-22' target='_blank'>\n    <img class='lazy' src='\n      <% if (navigator.userAgent.match(/(iPhone|iPod|iPad|Mobile|Android)/g)){ %>\n        <%='img/loading.gif' %>\n      <% }else{ %>\n        <%= book.get('image').replace('SL75','SL180') || 'img/noimage.gif' %>\n      <% } %>\n      ' data-original='<%= book.get('image').replace('SL75','SL180') || 'img/noimage.gif'%>' alt='<%= book.get('title') %>'>\n  </a></div>\n  <p class=\"author\"><%= book.get('author') %></p>\n  <p class=\"title\"><%= book.get('title').replace(/[^ -~｡-ﾟ]/g,\"  \").length > 80 ? book.get('title').substr(0,40) + \"...\" : book.get('title') %></p>\n  <p class=\"buttons\">\n    <a href='http://booklog.jp/users/georgeosd/archives/1/<%= book.get('asin') %>' target='_blank'><button class='btn booklog'>Booklog</button></a>\n    <a href='http://www.amazon.co.jp/gp/product/<%= book.get('asin') %>/ref=as_li_ss_il?ie=UTF8&camp=247&creative=7399&creativeASIN=<%= book.get('asin') %>&linkCode=as2&tag=<%= config.amazonuser %>-22' target='_blank'><button class='btn amazon'>Amazon</button></a>\n  </p>\n</div>\n<% }); %>";
      return _.template(litagFmt, {
        books: books,
        config: config
      });
    },
    display: function() {
      this.render();
      $(this.el).children('.item').removeClass('hide');
      return $("img.lazy").lazyload({
        event: "scroll"
      });
    }
  });
});

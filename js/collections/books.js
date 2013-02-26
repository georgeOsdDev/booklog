"use strict";
define(["underscore", "backbone", "config", "util/jsonp", "models/book.min"], function(_, Backbone, config, JSONP, Book) {
  var Books;
  return Books = Backbone.Collection.extend({
    model: Book,
    rank: "5",
    getUrl: function() {
      return "http://api.booklog.jp/json/" + config.bookloguser + "?category=0&count=100&rank=" + this.rank;
    },
    initialize: function() {
      var self;
      self = this;
      return this.on("next", function() {
        if (this.rank > 1) {
          this.rank -= 1;
          return this.fetch();
        } else {
          return self.trigger("end");
        }
      });
    },
    fetch: function() {
      var jsonp, self;
      self = this;
      jsonp = new JSONP(global);
      return jsonp.request(this.getUrl(), function(data) {
        _.each(data.books, function(book, idx) {
          if (book.asin) {
            book["rank"] = self.rank;
            return self.add(book);
          }
        });
        return self.trigger("next");
      });
    }
  });
});

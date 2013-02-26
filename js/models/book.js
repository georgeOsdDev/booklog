"use strict";
define(["backbone"], function(Backbone) {
  var Book;
  return Book = Backbone.Model.extend({
    defaults: {
      id: "",
      asin: "",
      title: "",
      author: "",
      image: ""
    }
  });
});

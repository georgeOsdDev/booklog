"use strict"
define ["backbone"],(Backbone) ->
  Book = Backbone.Model.extend
    defaults:
      id: ""
      asin: ""
      title: ""
      author: ""
      image: ""
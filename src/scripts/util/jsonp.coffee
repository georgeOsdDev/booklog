"use strict"
define ->
  class JSONP
    constructor: (context)->
      @s = {}
      global = context
      global.jsonpCallbacks = index: 0

    request: (url, cb) ->
      key = "_" + global.jsonpCallbacks.index++
      sep = "?"
      @s[key] = document.createElement("script")
      @s[key].type = "text/javascript"
      if url.indexOf("?") > 0 then sep = '&'
      @s[key].src = url + sep + "callback=" + "jsonpCallback" + key
      self = @
      global["jsonpCallback" + key] = (json) ->
        self.s[key].parentNode.removeChild self.s[key]
        delete global["jsonpCallback" + key]
        cb json

      document.getElementsByTagName("head")[0].appendChild @s[key]



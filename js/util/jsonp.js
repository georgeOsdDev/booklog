"use strict";
define(function() {
  var JSONP;
  return JSONP = (function() {

    function JSONP(context) {
      var global;
      this.s = {};
      global = context;
      global.jsonpCallbacks = {
        index: 0
      };
    }

    JSONP.prototype.request = function(url, cb) {
      var key, self, sep;
      key = "_" + global.jsonpCallbacks.index++;
      sep = "?";
      this.s[key] = document.createElement("script");
      this.s[key].type = "text/javascript";
      if (url.indexOf("?") > 0) {
        sep = '&';
      }
      this.s[key].src = url + sep + "callback=" + "jsonpCallback" + key;
      self = this;
      global["jsonpCallback" + key] = function(json) {
        self.s[key].parentNode.removeChild(self.s[key]);
        delete global["jsonpCallback" + key];
        return cb(json);
      };
      return document.getElementsByTagName("head")[0].appendChild(this.s[key]);
    };

    return JSONP;

  })();
});

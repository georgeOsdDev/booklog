"use strict";
require.config({
  urlArgs: "ts=" + new Date().getTime(),
  baseUrl: "js",
  paths: {
    jquery: ["http://cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min", "../vendor/jquery/jquery.min"],
    "jquery.lazyload": ["../vendor/jquery.lazyload/jquery.lazyload.min"],
    underscore: ["../vendor/underscore-amd/underscore-min"],
    backbone: ["../vendor/backbone-amd/backbone-min"],
    config: ["config/config"]
  },
  shim: {
    'jquery.lazyload': ['jquery']
  }
});

"use strict";
var global, requirement;

global = this;

requirement = ["underscore", "jquery", "jquery.lazyload", "backbone", "config", "util/jsonp.min", "views/shelf.min"];

require(requirement, function(_, jquery, lazy, Backbone, config, JSONP, Shelf) {
  var App, app;
  App = (function() {

    function App() {
      this.name = "Booklog";
      this.version = "1.0.0";
    }

    App.prototype.getName = function() {
      return this.name;
    };

    App.prototype.getVersion = function() {
      return this.version;
    };

    App.prototype.chkDependencies = function() {
      if (_) {
        console.log("underscore " + _.VERSION + " is ready");
      }
      if ($) {
        console.log("jquery " + $.prototype.jquery + " is ready");
      }
      if (Backbone) {
        console.log("backbone " + Backbone.VERSION + " is ready");
      }
      if (config) {
        console.log("config is ready", JSON.stringify(config));
      }
      return _ && $ && Backbone && config;
    };

    return App;

  })();
  app = new App();
  app.shelf = new Shelf();
  return $(function() {
    var navbar_top, scroll, status;
    navbar_top = $("#navbar").offset().top;
    scroll = 0;
    $(document).scroll(function() {
      scroll = $(this).scrollTop();
      if (navbar_top <= scroll) {
        return $("#navbar").addClass("follow_scroll");
      } else if (navbar_top >= scroll) {
        return $("#navbar").removeClass("follow_scroll");
      }
    });
    status = {
      rank_5: "show",
      rank_4: "show",
      rank_3: "show",
      rank_2: "show",
      rank_1: "show"
    };
    return $("#toggle_btn").children().on("click", function() {
      var target;
      target = $(this).data("target");
      if (status[target] === "show") {
        $("." + target).addClass("hide").removeClass("item show");
        status[target] = "hide";
        return $(this).removeClass("press");
      } else {
        $("." + target).addClass("item show").removeClass("hide");
        status[target] = "show";
        return $(this).addClass("press");
      }
    });
  });
});

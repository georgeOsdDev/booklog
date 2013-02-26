"use strict"
require.config
  urlArgs: "ts="+new Date().getTime()
  baseUrl: "js",
  paths:
    jquery: [
      "http://cdnjs.cloudflare.com/ajax/libs/jquery/1.9.1/jquery.min",
      "../vendor/jquery/jquery.min"
    ]
    "jquery.lazyload": [
      "../vendor/jquery.lazyload/jquery.lazyload.min"
    ]
    underscore: [
      "../vendor/underscore-amd/underscore-min"
    ]
    backbone: [
      "../vendor/backbone-amd/backbone-min"
    ]
    config: [
      "config/config"
    ]
  shim:
    'jquery.lazyload': ['jquery']
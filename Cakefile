log = console.log
{ exec } = require 'child_process'

task 'install', ->
  install()

install = ->
  exec 'bower install', (err, stdout, stderr)->
    throw err if err
    log stdout + stderr

    exec 'npm install', (err, stdout, stderr)->
	    throw err if err
	    log stdout + stderr

	    log "exec grunt run"

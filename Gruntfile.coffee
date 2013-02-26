module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean: ['public/vendor', 'public/js', 'public/css','node_modules']

    jshint:
      test: ['test/*.js']
      options:
        jshintrc: 'test/.jshintrc'

    coffeelint:
      src: ['src/scripts/**/*.coffee']
      gruntfile: ['Gruntfile.coffee']
      options:
        'no_tabs' :
          'level' : 'error'
        'no_trailing_whitespace' :
          'level' : 'error'
        'max_line_length' :
          'value': 120
          'level' : 'ignore'
        'camel_case_classes' :
          'level' : 'error'
        'indentation' :
          'value' : 2
          'level' : 'error'
        'no_implicit_braces' :
          'level' : 'ignore'
        'no_trailing_semicolons' :
          'level' : 'error'
        'no_plusplus' :
          'level' : 'ignore'
        'no_throwing_strings' :
          'level' : 'error'
        'cyclomatic_complexity' :
          'value' : 11
          'level' : 'ignore'
        'line_endings' :
          'value' : 'unix'
          'level' : 'ignore'
        'no_implicit_parens' :
          'level' : 'ignore'

    coffee:
      options:
        bare:true
      main:
        files:
          'public/js/main.js': ['src/scripts/main/*.coffee']
          'public/js/config/config.js': ['src/scripts/config/*.coffee']

      util:
        expand: true,
        cwd: 'src/scripts/util',
        src: ['*.coffee'],
        dest: 'public/js/util',
        ext: '.js'

      models:
        expand: true,
        cwd: 'src/scripts/models',
        src: ['*.coffee'],
        dest: 'public/js/models',
        ext: '.js'

      collections:
        expand: true,
        cwd: 'src/scripts/collections',
        src: ['*.coffee'],
        dest: 'public/js/collections',
        ext: '.js'

      views:
        expand: true,
        cwd: 'src/scripts/views',
        src: ['*.coffee'],
        dest: 'public/js/views',
        ext: '.js'

    uglify:
      main:
        options:
          #the banner is inserted at the top of the output
          banner: "/*! <%= pkg.name %> <%= grunt.template.today('dd-mm-yyyy') %> */\n"
        files:
          'public/js/main.min.js': ['public/js/main.js']
      util:
        files:
          'public/js/config/config.min.js': ['public/js/config/config.js']
          'public/js/util/jsonp.min.js': ['public/js/util/jsonp.js']
      models:
        files:
          'public/js/models/book.min.js': ['public/js/models/book.js']
      collections:
        files:
          'public/js/collections/books.min.js': ['public/js/collections/books.js']
      views:
        files:
          'public/js/views/shelf.min.js': ['public/js/views/shelf.js']

    stylus:
      compile:
        options:
          paths: ['node_modules','public/vendor/normalize-css/normalize.css']
          compress: false
        files:
          'public/css/main.css':['src/styles/main/main.styl']

    cssmin:
      compress:
        files:
          'public/css/main.normalized.min.css':['public/vendor/normalize-css/normalize.css','public/css/main.css']

    mochaTest:
      files: ['test/*.test.js']
    mochaTestConfig:
      options:
        reporter: 'nyan'

    watch:
      gruntfile:
        files: 'Gruntfile.coffee'
        tasks: ['coffeelint:gruntfile']
        options:
          nocase: true
      js:
        files: ['src/scripts/**/*.coffee']
        tasks: ['js']
      css:
        files: ['src/styles/**/*.styl']
        tasks: ['css']
      test:
        files: ['test/**.test.js']
        tasks: ['jshint:test', 'mochaTest']

  # load
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'

  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-mocha-test'

  grunt.loadNpmTasks 'grunt-contrib-watch'

  # regist
  grunt.registerTask 'initialize', ['clean','install_message']

  grunt.registerTask 'compile', ['coffeelint','mochaTest','coffee','uglify','stylus','cssmin']

  grunt.registerTask 'test', ['jshint','mochaTest']

  grunt.registerTask 'js', ['coffeelint','mochaTest','coffee','uglify']

  grunt.registerTask 'css', ['stylus','cssmin']

  grunt.registerTask 'default', 'Log some stuff.', ->
    grunt.log.write("do 'grunt initialize' or 'grunt compile' or 'grunt run' or some stuff").ok()

  grunt.registerTask 'install_message', 'Log some stuff.', ->
    grunt.log.write('!! exec cake install !!  ').ok()

  grunt.registerTask 'run',['compile','watch']

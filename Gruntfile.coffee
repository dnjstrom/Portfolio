'use strict'

module.exports = (grunt) ->

  # Load grunt tasks automatically
  require('load-grunt-tasks')(grunt)

  # Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt)

  # Define the configuration for all the tasks
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'
    project:
      app: 'app'
      dist: 'dist'

    jade:
      build:
        files: [
          expand: true
          cwd: '<%= project.app %>'
          src: ['**/*.jade']
          dest: '<%= project.dist %>'
        ]

    coffee:
      build:
        files: [
          expand: true
          cwd: '<%= project.app %>'
          src: ['**/*.coffee']
          dest: '<%= project.dist %>'
        ]

    stylus:
      build:
        files: [
          expand: true
          cwd: '<%= project.app %>'
          src: ['**/*.styl']
          dest: '<%= project.dist %>'
        ]

    clean:
      dist: ['<%= project.dist %>']

  grunt.registerTask 'build', ['jade:build', 'coffee:build', 'stylus:build']

  grunt.registerTask 'default', []

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
			tmp: '.tmp'

		watch:
			js:
				files: ['**/*.coffee']
				tasks: ['coffee:build']
			styles:
				files: ['**/*.styl']
				tasks: ['stylus:build']
			html:
				files: ['**/*.jade']
				tasks: ['jade:build']
			livereload:
				options:
					livereload: '<%= connect.options.livereload %>'
				files: [
					'<%= project.dist %>/**/*'
				]

		connect:
			options:
				port: 9000
				livereload: 35729
				# Change this to '0.0.0.0' to access the server from outside
				hostname: 'localhost'
			livereload:
				options:
					open: true
					base: ['<%= project.dist %>']

		jade:
			build:
				files: [
					expand: true
					cwd: '<%= project.app %>'
					src: ['**/*.jade']
					dest: '<%= project.dist %>'
					ext: '.html'
				]

		coffee:
			build:
				files: [
					expand: true
					cwd: '<%= project.app %>'
					src: ['**/*.coffee']
					dest: '<%= project.dist %>'
					ext: '.js'
				]

		stylus:
			build:
				files: [
					expand: true
					cwd: '<%= project.app %>'
					src: ['**/*.styl']
					dest: '<%= project.dist %>'
					ext: '.css'
				]

		autoprefixer:
			options:
				browsers: ['last 1 version']
			build:
				files: [
					expand: true
					cwd: '<%= project.dist %>'
					src: '**/*.css'
					dest: '<%= project.dist %>'
				]

		'bower-install':
			build:
				html: '<%= project.dist %>/index.html',
				ignorePath: '<%= project.app %>/'

		clean:
			dist: ['<%= project.dist %>']

	grunt.registerTask 'build', [
		'clean'
		'jade:build'
		'coffee:build'
		'stylus:build'
		'autoprefixer'
		'bower-install'
		'copy:bower'
	]

	grunt.registerTask 'serve', ['build', 'connect:livereload', 'watch']

	grunt.registerTask 'default', []
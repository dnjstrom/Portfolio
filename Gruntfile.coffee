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
				tasks: ['jade:build', 'bower-install']
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
				options:
					pretty: true
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
					dest: '<%= project.tmp %>'
					ext: '.js'
				]

		stylus:
			build:
				files: [
					expand: true
					cwd: '<%= project.app %>'
					src: ['**/*.styl']
					dest: '<%= project.tmp %>'
					ext: '.css'
				]

		autoprefixer:
			options:
				browsers: ['last 1 version']
			build:
				files: [
					expand: true
					cwd: '<%= project.tmp %>'
					src: '**/*.css'
					dest: '<%= project.tmp %>'
				]

		'bower-install':
			build:
				html: '<%= project.dist %>/index.html',
				ignorePath: '<%= project.app %>/'

		rev:
			dist:
				src: '<%= project.dist %>/{scripts,styles}/**/*'

		useminPrepare:
			options:
				dest: '<%= project.dest %>'
				root: '<%= project.tmp %>'
			html: '<%= project.dist %>/index.html'

		usemin:
			options:
				assetsDirs: ['<%= project.dist %>']
			html: '<%= project.dist %>/**/*.html'

		htmlmin:
			dist:
				options:
					collapseBooleanAttributes: true
					collapseWhitespace: true
					removeAttributeQuotes: true
					removeCommentsFromCDATA: true
					removeEmptyAttributes: true
					removeOptionalTags: true
					removeRedundantAttributes: true
					useShortDoctype: true
				files: [
					expand: true
					cwd: '<%= project.dist %>'
					src: '**/*.html'
					dest: '<%= project.dist %>'
				]

		copy:
			tmp:
				files: [
					expand: true
					cwd: '<%= project.tmp %>'
					src: '**/*'
					dest: '<%= project.dist %>/'
				]
			bower_components:
				files: [
					expand: true
					cwd: '<%= project.app %>/bower_components'
					src: '**/*'
					dest: '<%= project.dist %>/bower_components'
				]

		clean:
			dist: ['<%= project.dist %>']
			tmp: ['<%= project.tmp %>']


	grunt.registerTask 'dist', [
		'clean'
		'jade:build'
		'bower-install'
		'useminPrepare'
		'coffee:build'
		'stylus:build'
		'autoprefixer'
		'concat'
		'cssmin'
		'uglify'
		'rev'
		'usemin'
		'htmlmin'
	]

	grunt.registerTask 'build', [
		'clean'
		'jade:build'
		'bower-install'
		'coffee:build'
		'stylus:build'
		'autoprefixer'
		'copy'
	]

	grunt.registerTask 'serve', ['build', 'connect:livereload', 'watch']

	grunt.registerTask 'default', []

gulp = require 'gulp'
sass = require('gulp-sass')
jade = require('gulp-jade')
coffee = require('gulp-coffee')
browserSync = require('browser-sync')
plumber = require('gulp-plumber')

scss_path = './app/styles/**/*.scss'

gulp.task 'server', ->
  browserSync.init
    server:
      baseDir: "./public"

gulp.task 'reload', ->
  browserSync.reload()

gulp.task 'coffee', ->
  gulp
    .src './app/scripts/**/*.coffee'
    .pipe plumber()
    .pipe coffee()
    .pipe gulp.dest './public'

gulp.task 'scss', ->
  gulp
    .src './app/styles/**/*.scss'
    .pipe plumber()
    .pipe sass()
    .pipe gulp.dest './public'

gulp.task 'jade', ->
  gulp
    .src './app/*.jade'
    .pipe plumber()
    .pipe jade()
    .pipe gulp.dest './public'

gulp.task 'watch', ['build', 'server'], ->
  gulp.watch ['./app/styles/**/*.scss'], ['scss', 'reload']
  gulp.watch ['./app/*.jade'], ['jade', 'reload']
  gulp.watch ['./app/scripts/**/*.coffee'], ['coffee', 'reload']

gulp.task 'build', ['jade', 'coffee', 'scss']
gulp.task 'default', ['build']

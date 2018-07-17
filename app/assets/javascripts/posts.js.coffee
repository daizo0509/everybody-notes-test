# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  new Vue
    el: '#markdown_editor'
    data:
      input: '#post_content'
    filters:
      marked: marked
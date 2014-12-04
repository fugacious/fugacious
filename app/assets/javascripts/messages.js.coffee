# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "keydown", (e) ->
  if (e.keyCode is 27)
     $('.alert').fadeOut() 
  return
  
.keypress (e) ->
  if (e.keyCode is 32) or (e.keyCode is 88) or (e.keyCode is 120)
     $('.alert').fadeOut() 
  return

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('.reservations_show a').pjax('[data-pjax-container]')

  $('#reserv_show_date_pick').datepicker()

  return 0

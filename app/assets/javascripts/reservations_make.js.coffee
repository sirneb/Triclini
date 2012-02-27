# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

MODAL_LAST_PAGE = 4

$ ->

  $('#make_reservation').modal( {backdrop:true, keyboard:false} )

  $('#modal_date_pick').datepicker()

  ## Handle the modal pages
  $('#modal_next').bind('click', ->
    page_num = parseInt $(@).attr('page_data')

    ## Set up for future pages
    $(this).attr 'page_data', page_num+1
    $('#modal_prev').attr 'page_data', page_num-1

    ## Hide old, display new
    $('.pages').hide()
    $('#step'+page_num).show()

    if page_num == 2
      $('#modal_prev').removeClass "disabled"
      bindModalPrev()

    if page_num == MODAL_LAST_PAGE
      $(@).hide()
      $('#modal_save').show()
  )

bindModalPrev =  ->
  $('#modal_prev').bind 'click', ->
    page_num = parseInt($(this).attr('page_data'))

    ## Set up for future pages
    $(@).attr 'page_data', page_num-1
    $('#modal_next').attr 'page_data', page_num+1

    ## Hide old, display new
    $('.pages').hide()
    $('#step'+page_num).show()

    if page_num == 1
      $(@).addClass "disabled"
      $(@).unbind 'click'

    if page_num == MODAL_LAST_PAGE-1
      $('#modal_next').show()
      $('#modal_save').hide()
  

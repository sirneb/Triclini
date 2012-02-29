# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

MODAL_LAST_PAGE = 4

$ ->

  ($ '#make_reservation').modal( {backdrop:true, keyboard:false, show:false} )

  ($ '#reservation_wiz_trigger').live 'click', -> ($ '#make_reservation').modal 'show'

  ($ '#modal_date_pick').datepicker()

  makeReservation = new PrevNextSave('#make_reservation', 4)
  makeReservation.bind()

class PrevNextSave
  constructor: (mainDiv, numOfPages) ->
    @mainDiv = mainDiv
    @nextBindId = '#next'
    @prevBindId = '#prev'
    @saveBindId = '#save'
    @pageClass = '.pages'
    @numOfPages = numOfPages

  bind: ->
    $nextBind = ($ @mainDiv + ' '+@nextBindId)
    $prevBind = ($ @mainDiv + ' '+@prevBindId)
    currentPage = 1

    $nextBind.bind 'click', =>

      newCurrentPage = currentPage+1
      
      ## Set up button's new redirection
      $nextBind.attr 'page_data', newCurrentPage+1
      $prevBind.attr 'page_data', currentPage

      ## Hide old, display new
      ($ @mainDiv + ' '+@pageClass).hide()
      ($ @mainDiv + ' #step'+newCurrentPage).show()

      if currentPage == 1
        ($ @mainDiv + ' ' + @prevBindId).removeClass "disabled" # uses bootstrap
        bindPrev()

      if newCurrentPage == @numOfPages
        $nextBind.hide()
        ($ @mainDiv + ' ' + @saveBindId).show()

      currentPage++

    bindPrev = =>
      $prevBind.bind 'click', =>
        newCurrentPage = currentPage-1

        ## Set up for future pages
        $prevBind.attr 'page_data', newCurrentPage-1
        $nextBind.attr 'page_data', currentPage

        ## Hide old, display new
        ($ @mainDiv + ' ' + @pageClass).hide()
        ($ @mainDiv + ' #step' + newCurrentPage).show()

        if newCurrentPage == 1
          $prevBind.addClass "disabled" # uses bootstrap
          $prevBind.unbind 'click'

        if currentPage == @numOfPages
          $nextBind.show()
          ($ @mainDiv + ' ' + @saveBindId).hide()

        currentPage--


  ## Handle the modal pages@
#   ($ '#modal_next').bind 'click', ->
#     page_num = parseInt $(@).attr('page_data')
# 
#     ## Set up for future pages
#     $(this).attr 'page_data', page_num+1
#     ($ '#modal_prev').attr 'page_data', page_num-1
# 
#     ## Hide old, display new
#     ($ '.pages').hide()
#     ($ '#step'+page_num).show()
# 
#     if page_num == 2
#       ($ '#modal_prev').removeClass "disabled"
#       bindModalPrev()
# 
#     if page_num == MODAL_LAST_PAGE
#       $(@).hide()
#       ($ '#modal_save').show()
#   
# 
# bindModalPrev =  ->
#   ($ '#modal_prev').bind 'click', ->
#     page_num = parseInt $(this).attr('page_data')
# 
#     ## Set up for future pages
#     $(@).attr 'page_data', page_num-1
#     ($ '#modal_next').attr 'page_data', page_num+1
# 
#     ## Hide old, display new
#     ($ '.pages').hide()
#     ($ '#step'+page_num).show()
# 
#     if page_num == 1
#       $(@).addClass "disabled"
#       $(@).unbind 'click'
# 
#     if page_num == MODAL_LAST_PAGE-1
#       ($ '#modal_next').show()
#       ($ '#modal_save').hide()
  

# CoffeeScript file for Scoring Engine

scoring_magic = ->
  
  $.ajaxSetup
    beforeSend: (xhr) -> xhr.setRequestHeader('Accept', 'text/javascript')
  
  # chosen select
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '100%'

  # date time picker
  $('.datetimepicker').datetimepicker
    format: 'YYYY-MM-DD hh:mm:ss a Z'

  $(document).on 'click', '.add_nested_item', addNestedItem
  $(document).on 'click', '.remove_nested_item', removeNewItem
  $(document).on 'click', '.panel-heading', panelToggle

addNestedItem = (event) ->
  event.preventDefault()
  event.stopImmediatePropagation()
  template = eval $(this).attr('href').replace(/.*#/,'')
  rel = "##{$(this).attr('rel')}"
  $(rel).append replace_ids(template)
  $(rel).children().last().find('input[type="text"]').first().focus()

replace_ids = (s) -> return s.replace(/NEW_RECORD/g, new Date().getTime())

removeNewItem = (event) ->
  event.preventDefault()
  rel = "##{$(this).attr('rel')}"
  $(rel).fadeOut 500, ->
    $(rel).remove()

panelToggle = (event) ->
  event.preventDefault()
  event.stopImmediatePropagation()
  if $(@).data('rel')
    $(@).find('i').toggleClass('fa-caret-square-o-right').toggleClass('fa-caret-square-o-down')
    $($(@).data('rel')).toggle 200

window.replace_ids = replace_ids

$ ->
  scoring_magic();

$(window).bind 'page:change', ->
  scoring_magic();

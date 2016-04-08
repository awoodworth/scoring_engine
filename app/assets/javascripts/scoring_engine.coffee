# CoffeeScript file for Scoring Engine

scoring_magic = ->
  
  $.ajaxSetup
    beforeSend: (xhr) -> xhr.setRequestHeader('Accept', 'text/javascript')
  
  # chosen select
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '300px'

$ ->
  scoring_magic();

$(window).bind 'page:change', ->
  scoring_magic();

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

  # form handlers
  $(document).on 'click', '.add_nested_item', addNestedItem
  $(document).on 'click', '.remove_nested_item', removeNewItem
  $(document).on 'click', '.panel-heading-click', panelToggle

  # ctf remote form handler
  $('form.ctf_form')
    .bind 'ajax:beforeSend', ->
      event.preventDefault()
      $($(@).data('rel')).append spin
    .bind 'ajax:success', (event, data, status, xhr) ->
      rel = $(@).data('rel')
      target = $(@).data('target')
      if /^incorrect/i.test(data)
        num = data.split(',')[1]
        $(target).html(num)
        $(target).effect("highlight", {color: "#d9534f"}, 1500);
        $(@)[0].reset()
        $(@).find('label.active').removeClass('active')
        if num == "0"
          $(@).parent().addClass('center').html "<i class='fa fa-minus-circle red'></i>"
      if /^correct/i.test(data)
        $($(@).data('target')).html "<i class='fa fa-star green'></i>"
        $(@).parent().addClass('center').html "<i class='fa fa-check-circle green'></i>"
      $.get $(@).data('url')+'.json', (data) ->
        $(target).attr 'data-original-title', data.join("\r\n")
      $('.fancy-spinner').fadeOut 200, ->
        $(@).remove()
    .bind 'ajax:error', (xhr, data, status) ->
      rel = $(@).data('rel')
      target = $(@).data('target')
      if /^max\sattempts\sreached/i.test(data.responseText)
        $(target).html "0"
        $(rel).parent().addClass('center').html "<i class='fa fa-minus-circle red'></i>"
    .bind 'ajax:complete', ->
      $('.fancy-spinner').fadeOut 200, ->
        $(@).remove()

  toolTip()


reloadChosen = (event) ->
  $('.chosen-select').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '100%'

toolTip = ->
  $('[data-toggle="tooltip"]').tooltip()

addNestedItem = (event) ->
  event.preventDefault()
  template = eval $(this).attr('href').replace(/.*#/,'')
  rel = "##{$(this).attr('rel')}"
  $(rel).append replace_ids(template)
  $(rel).children().last().find('input[type="text"]').first().focus()
  reloadChosen()

replace_ids = (s) -> return s.replace(/NEW_RECORD/g, new Date().getTime())

removeNewItem = (event) ->
  event.preventDefault()
  rel = "##{$(this).attr('rel')}"
  $(rel).fadeOut 500, ->
    $(rel).remove()

panelToggle = (event) ->
  event.preventDefault()
  if $(@).data('rel')
    $(@).find('i').toggleClass('fa-caret-square-o-right').toggleClass('fa-caret-square-o-down')
    $($(@).data('rel')).toggle 200

spin = -> return "<div class='fancy-spinner' style='position: absolute !important; left: 0px; width: 100%; height: 100%; margin-top: -10px'><h2 class='center'><i class='fa fa-circle-o-notch fa-spin'></i></h2></div>"

window.replace_ids = replace_ids

$(window).bind 'page:change', ->
  scoring_magic();

$ = jQuery

$(document).ready () ->
  $('#chatform').submit (e) ->
    $.ajax({
      type: 'post'
      url: '/message'
      data: $('#chatform').serialize()
    })
    e.preventDefault()
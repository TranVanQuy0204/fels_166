$(document).on 'ready page:load', ->
  $('#login_button').on 'click', (event) ->
    $('#login_one').slideToggle(1000);
    event.stopPropagation();

  $('#word_category').on 'change', (event) ->
    url = $('#word_category').attr('data-url');
    data = $('#word_category').val();
    url = url + '?search=' +data
    window.location = url

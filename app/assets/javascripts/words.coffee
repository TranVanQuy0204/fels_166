@show_word_answer = (el) ->
  url = $(el).attr('href')
  $.get
    url: url
    dataType: 'json'
    success: (data) ->
      $('.show_word_answer_'+data.word_id).html(data.answers)
      $('.show_word_answer_'+data.word_id).toggle()
      return false
  return false

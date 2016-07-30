@admin_show_word_answer = (el) ->
  url = $(el).attr('href')
  $.get
    url: url
    dataType: 'json'
    success: (data) ->
      $('.show_word_answer_' + data.word_id).html(data.answers)
      return false
  return false

@category_add_word = (el) ->
  $('.category_notifi').addClass('hidden')
  url = $(el).attr('data-url')
  method = 'PUT'
  if($(el).hasClass('glyphicon-minus'))
    method = 'DELETE'
  $.ajax
    url: url
    dataType: 'json'
    method: method
    data: {category_id: $(el).attr('data-category-id')}
    success: (data) ->
      if(data.result)
        if(method == 'PUT')
          $(el).removeClass('glyphicon-plus-sign');
          $(el).addClass('glyphicon-minus');
          $($(el).parents('tr').find('.depend')).removeClass('hidden')
          $($(el).parents('tr').find('.independ')).addClass('hidden')
        else
          $(el).removeClass('glyphicon-minus');
          $(el).addClass('glyphicon-plus-sign');
          $($(el).parents('tr').find('.independ')).removeClass('hidden')
          $($(el).parents('tr').find('.depend')).addClass('hidden')
      else
        $('.category_notifi').removeClass('hidden')
      return false
  return false

@admin_delete_word_answer = (el, total) ->
  id = $(el).attr('data-id')
  alert(id)

@admin_add_word_answer = (el, total) ->
  answer_count = $('#word_answer_count').val()
  if 0 <= answer_count < 6
    answer_count += 1
    strVar="";
    strVar += "<div class=\"row\">";
    strVar += "<div class=\"form-group\">";
    strVar += "     <div class=\"col-md-8\">";
    strVar += "<input type=\"text\" id=\"word_word_answers_attributes_"+answer_count+"_content\" name=\"word[word_answers_attributes]["+answer_count+"][content]\" class=\"form-control\">";
    strVar += "<\/div>";
    strVar += "<div class=\"col-md-1\">";
    strVar += "<input type=\"radio\" id=\"word_word_answers_attributes_"+answer_count+"_is_correct_email\" name=\"word[word_answers_attributes][0][is_correct]\" >";
    strVar += "<\/div>";
    strVar += "<div class=\"col-md-2\">";
    strVar += "<button onclick=\"return admin_delete_word_answer(this)\" class=\"btn glyphicon glyphicon-trash\" type=\"button\" name=\"button\"><\/button>";
    strVar += "<\/div>";
    strVar += "<\/div>";
    strVar += "<\/div>";
    $('.show_answer_form').append(strVar);
    $('#word_answer_count').val(answer_count)
  else
    alert(2)

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

@admin_delete_word_answer = (el) ->
  answer_count = parseInt $('#word_answer_count').val()
  row_parents = $($(el).parents('.row'))[0]
  if $($(row_parents).find('input')[1]).is(':checked')
    alert("You don't remove this element")
  else
    answer_count = answer_count - 1
    $($(row_parents).find('input')[3]).prop("checked", true)
    $(row_parents).addClass('hidden')
    $('#word_answer_count').val(answer_count)


@admin_add_word_answer = (el) ->
  answer_count = parseInt $('#word_answer_count').val()
  if 1 <= answer_count < 5
    answer_count = answer_count + 1
    $('.row-word-answer').find('.row').each ->
      hidden_class = $(this)
      if $(hidden_class).hasClass('hidden')
        $(this).removeClass('hidden')
        $($(this).find('input')[3]).prop("checked", false)
        $('#word_answer_count').val(answer_count)
        return false;
  else
    alert("Answer 2 to 5")
@admin_choose_answer = (el) ->
  $('.row-word-answer').find('.row').each ->
    $($(this).find('input')[1]).prop("checked", false)
    correct_answer_input = $(this).find('input')[4]
    $(correct_answer_input).val(0)
  $(el).prop("checked", true)
  id = $(el).attr('id').replace('_true', '');
  $('#'+id).val(1)

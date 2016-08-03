$(document).on('ready page:load', function() {
  $('.list-word li:gt(0)').hide();
  $('.list-word :first').addClass('word-show')
  $('#btn_last').hide();
  $('#btn_result').hide();
  $('#btn_next').on('click', function(event) {
    var index = $('.list-word li').index($('li.word-show'))
    word_show = $('.list-word li')[index];
    $(word_show).removeClass('word-show');
    $(word_show).hide();
    word_next = $('.list-word li')[index + 1];
    $(word_next).addClass('word-show');
    $(word_next).show();
    $('#btn_last').show();
    if($('.list-word li').length == index + 2){
      $('#btn_next').hide();
      $('#btn_result').show();
    }
  })
  $('#btn_last').on('click', function(event) {
    var index = $('.list-word li').index($('li.word-show'))
    word_show = $('.list-word li')[index];
    $(word_show).removeClass('word-show');
    $(word_show).hide();
    word_next = $('.list-word li')[index - 1];
    $(word_next).addClass('word-show');
    $(word_next).show();
    $('#btn_next').show();
    $('#btn_result').hide();
    if(index == 1){
      $('#btn_last').hide();
    }
  })
})


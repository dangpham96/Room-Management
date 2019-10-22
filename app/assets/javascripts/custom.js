// function call_ajax() {
//   let name = $('#find_by_name_user').val();
//   $.ajax({
//     url: '/search',
//     type: 'POST',
//     dataType: 'script',
//     data: {name: name}
//   });
// }

// $(document).on("turbolinks:load",function(){
//   $(document).on ('keyup', '#find_by_name_user', function(){
//     call_ajax();
//   });
// })

function load_data_room() {
  return new Promise((resolve, reject) => {
    var data = {};
    data['status'] = $('#find_by_status_room').val();
    resolve(data);
  });
}

function load_data_user() {
  return new Promise((resolve, reject) => {
    var data = {};
    data['name'] = $('#find_by_name_user').val();
    resolve(data);
  });
}
function load_data_feed_back() {
  return new Promise((resolve, reject) => {
    var data = {};
    data['title'] = $('#find_by_title_fb').val();
    resolve(data);
  });
}

function call_ajax(url, type, data) {
  $.ajax({
    url: url,
    type: type,
    dataType: 'script',
    data: data
  });
}

$(document).on ('change', '#find_by_status_room', function(){
  load_data_room().then(data => {
    call_ajax('/search_room', 'POST', data);
  });
});

$(document).on ('keyup', '#find_by_name_user', function(){
  load_data_user().then(data => {
    call_ajax('/search_user', 'POST', data);
  });
});

$(document).on ('keyup', '#find_by_title_fb', function(){
  load_data_feed_back().then(data => {
    call_ajax('/search_feed_back', 'POST', data);
  });
});

$(document).on("turbolinks:load",function(){
  $('.fa.fa-home').on( "click", function() {
    $('.action_room').removeClass('active')
    $(this).parent().find('.action_room ').addClass('active')
  });
})

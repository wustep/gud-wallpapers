/*
Wallpapers tags input logic

Author:: Nishad
*/

$(document).ready(function() {

  // Prevent enter from submitting forms (so that tags can be added with enter)
  $('form input').keydown(function(event){
    if(event.keyCode == 13) {
      event.keyCode == 44;
    }
  });

  // When the add tags button is clicked, hide the tag list and
  // create an input to add tags
  $('#plus').click(function() {
    $('#user-tags').hide();
    $('#plus').hide();
    $('#user-tags-input-container').css("display", "inline");
    $("#user-tags-input").tagsinput();
    $("#user-tags-input").tagsinput('input').focus();
  });

  //When the input s unfocused, hide it and show the (updated) tag list once again
  $('#user-tags-input-container').focusout(function() {
    $('#user-tags-input-container').hide();
    $("#user-tags-input").tagsinput('destroy');
    $('#user-tags').show();
    $('#plus').show();
  });

  //Use AJAX to add tags to the model as the user types them in
  $('#user-tags-input').on('beforeItemAdd', function(event) {
    var tagList = $('#user-tags-input').val() + "," + event.item;
    var data = {taglist: tagList}
    if(!event.options || !event.options.preventPost) {
      $.ajax({
        url: window.location.href + '/updatetags',
        type: 'PUT',
        data: data,
        success: function(data) {

        },
        error(xhr,status, error) {
          alert('error');
        }
      });
    }
  });

});

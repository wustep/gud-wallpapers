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

  // When the add tags button is clicked, hide the tag list and create an input to add tags
  $('#plus').click(function() {
    $('#user-tags').hide();
    $('#plus').hide();
    $('#user-tags-input-container').css("display", "inline");
    $("#user-tags-input").tagsinput();
    $("#user-tags-input").tagsinput('input').focus();
  });

  // When the input is unfocused, hide it and show the (updated) tag list once again
  $('#done').click(function() {
    $('#user-tags-input-container').hide();
    $('#user-tags').show();
    $('#plus').show();
  });

  // Use AJAX to add tags to the model as the user types them in
  $('#user-tags-input').on('itemAdded', function(event) {
    var tag = event.item;
    var tagList = $('#user-tags-input').val();
    var data = {taglist: tagList}
    if(!event.options || !event.options.preventPost) {
      $.ajax({
        url: window.location.href + '/updatetags',
        type: 'PUT',
        data: data,
        error(xhr,status, error) {
          //Remove the tag on failure
          if(onRemove) {
            $('#user-tags-input').tagsinput('remove', event.item, {preventPost: true})
          } else {
            $('#user-tags-input').tagsinput('add', event.item, {preventPost: true})
          }
        }
      });
    }
  });

  // Use AJAX to remove tags from the model as the user deletes them.
  $('#user-tags-input').on('itemRemoved', function(event) {
    var tag = event.item;
    var tagList = $('#user-tags-input').val();
    var data = {taglist: tagList}
    if(!event.options || !event.options.preventPost) {
      $.ajax({
        url: window.location.href + '/updatetags',
        type: 'PUT',
        data: data,
        error(xhr,status, error) {
          //Add the tag back on failure
            $('#user-tags-input').tagsinput('add', event.item, {preventPost: true})
        }
      });
    }
  });

});

/*
Wallpapers tags input logic

Author:: Nishad
*/

$(document).ready(function() {


  $('form input').keydown(function(event){
    if(event.keyCode == 13) {
      event.keyCode == 44;
    }
  });

  var createModal = function() {
    //JS called that creates upload form modal
    $('<%= j render "form" %>').on('shown.bs.modal', function(e) {
      $("input[data-role=tagsinput], select[multiple][data-role=tagsinput]").tagsinput();
    }).on('hidden.bs.modal', function() {
      $(this).data('bs.modal', null);
      $(this).remove();
    }).modal();

  }

});

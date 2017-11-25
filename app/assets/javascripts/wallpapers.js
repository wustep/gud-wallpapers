
$(document).ready(function() {
  $("input[data-role=tagsinput], select[multiple][data-role=tagsinput]").tagsinput();
  $('form input').keydown(function(event){
    if(event.keyCode == 13) {
      event.keyCode == 44;
    }
  });
});

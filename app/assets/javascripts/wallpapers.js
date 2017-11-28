/*
Wallpapers tags input logic

Author:: Nishad
*/

$(document).ready(function() {
<<<<<<< HEAD

  
  $('form input').keydown(function(event){
    if(event.keyCode == 13) {
=======
  $("input[data-role=tagsinput], select[multiple][data-role=tagsinput]").tagsinput();
  $('form input').keydown(function(event) {
    if (event.keyCode == 13) {
>>>>>>> ee7be09619c06c37b6e68194b999edbe6c5f8376
      event.keyCode == 44;
    }
  });


});

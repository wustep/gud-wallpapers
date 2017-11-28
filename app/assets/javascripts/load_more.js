/*
Load More Wallpapers button handler

Author:: Nishad
*/

$(document).ready(function () {
  var isLoading = false;
  //Make sure there are still pages left
  if ($('.pagination').length) {
    $('#load-more').on('click', function() {
      //Get url of next page
      var more_wallpapers_url = $('.pagination a[rel=next]').attr('href');
      //Check that we are not already loading more
      if (!isLoading && more_wallpapers_url) {
        isLoading = true;
        //GET request to next page
        $.getScript(more_wallpapers_url).done(function (data,textStatus,jqxhr) {
          isLoading = false;
        }).fail(function() {
          isLoading = false;
        });
      }
    });
  } else {
    $('#load-more').remove();
  }
});

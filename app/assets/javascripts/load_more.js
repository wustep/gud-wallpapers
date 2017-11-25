$(document).ready(function () {
  var isLoading = false;
  if ($('#infinite-scrolling').size() > 0) {
    $('#load-more').on('click', function() {
      var more_wallpapers_url = $('.pagination a[rel=next]').attr('href');
      if (!isLoading && more_wallpapers_url) {
        isLoading = true;
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

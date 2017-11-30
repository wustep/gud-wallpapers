# Controller for the advanced search feature.
# Searches the database for wallpapers matching keywords in the title or tag list
# as well as image height and width. Each search field is optional.
#
# Author(11/29/17): Martin
class SearchController < ApplicationController
    def adv_search
      @wallpapers = Wallpaper.adv_search(params[:title], params[:tags], params[:image_height], params[:image_width])
      if @wallpapers.class == Array
        @wallpapers = Kaminari.paginate_array(@wallpapers).page(params[:page]).per(28)
      else
        @wallpapers = @wallpapers.page params[:page]
      end
      @search = true
      render 'wallpapers/index'
    end

    def new
    end
end

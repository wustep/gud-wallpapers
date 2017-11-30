# Controller for the advanced search feature.
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
      render 'wallpapers/index' 
    end

    def new
    end
end

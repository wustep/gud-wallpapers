# Controller for the advanced search feature.
#
# Author: Martin
class SearchController < ApplicationController
    def adv_search
      @wallpapers = Wallpaper.adv_search(params[:title], params[:tags])
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

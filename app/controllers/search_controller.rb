# Controller for the advanced search feature.
# Searches the database for wallpapers matching keywords in the title or tag list
# as well as image height and width. Each search field is optional.
#
# Author(11/29/17): Martin
class SearchController < ApplicationController

    # Controller action that searches for wallpapers using title, tags, and dimensions
    # POST /advsearch
    #
    # Author: Martin
    def adv_search
      @wallpapers = Wallpaper.adv_search(params[:title], params[:tags], params[:image_height], params[:image_width])
      # The tag search function returns an array instead of an active record collection, so we need to check for this special case to paginate
      if @wallpapers.class == Array
        @wallpapers = Kaminari.paginate_array(@wallpapers).page(params[:page]).per(28)
      else
        @wallpapers = @wallpapers.page params[:page]
      end
      # Boolean that is checked when needing to display certain elements.
      @search = true
      render 'wallpapers/index'
    end

    # Controller action that grabs the search form
    # GET /search/new
    #
    # Author: Martin
    def new
      respond_to do |format|
        format.js
      end
    end
end

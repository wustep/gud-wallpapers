# User Controller class
#
# Author:: Stephen, Jason
# Help:: https://auth0.com/docs/quickstart/webapp/rails/03-user-profile

class UsersController < ApplicationController
  #include Secured
  # GET /user/:id
  def show
    @favorites = @user.favorite_wallpapers

    @user = User.find(params[:id])
    #Make sure the user passed in through the parameters matches that from the current user method
    if @user == current_user
      #Find out which gallery should be displayed
      if params[:gallery] == 'favorites'
        @wallpapers = @user.favorite_wallpapers
      #Default should be the uploaded gallery
      else
        @wallpapers = @user.uploads
      end
      #@wallpapers = Wallpaper.all
    #Redirect to index if not
    else
      redirect_to :controller=>"wallpapers", :action =>"index"
    end
  end
end

# User Controller class
#
# Author:: Jason
# Reference:: https://auth0.com/docs/quickstart/webapp/rails/03-user-profile

class UsersController < ApplicationController
  # include Secured
  # Controller action that gets the current users profile page
  # GET /user/:id
  #
  # Author: Jason
  def show
    @user = User.find_by_id(params[:id])
    #Make sure the user passed in through the parameters matches that from the current user method
    if !@user.nil? && !current_user.nil? && @user == current_user
      #Find out which gallery should be displayed
      if params[:gallery] == 'favorites'
        @wallpapers = @user.favorite_wallpapers
      #Default should be the uploaded gallery
      else
        @wallpapers = @user.uploads
      end
    #Redirect to index if not
    else
      redirect_to :controller=>"wallpapers", :action =>"index"
    end
  end
end

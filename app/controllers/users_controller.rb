# User Controller class
#
# Author:: Stephen
# Help:: https://auth0.com/docs/quickstart/webapp/rails/03-user-profile

class UsersController < ApplicationController
  include Secured
  # GET /user
  def index
    @user = session[:userinfo]
  end
end
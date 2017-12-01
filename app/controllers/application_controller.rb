# ApplicationController class
# Containing methods to check user authentication from omniauth
#
# Author:: Nishad, Stephen

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?
  # Function that grabs the current user who is logged in.
  # If nil, then no one is logged int.
  #
  #Author: Nishad
	def current_user
	   User.find_by(uid: session[:user_id]) if session[:user_id]
	end

  # Function that is called before any actions that need authorization.
  #
  # Author: Nishad
	def authorize!
    respond_to do |format|
      format.html {redirect_to "/auth/auth0" unless current_user}
      format.js { (render :js => "window.location = '/auth/auth0'") unless current_user}
    end
  end

  # Checks if the user is signed in
  #
  #Author: Nishad
  def signed_in?
    !!current_user
  end

  # Sets the current user
  #
  #Author: Nishad
  def set_current_user(user)
    @current_user = user
    session[:user_id] = user.nil? ? nil : user.uid
  end
end

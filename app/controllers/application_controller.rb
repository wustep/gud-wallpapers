# ApplicationController class

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :signed_in?

	def current_user
	   User.find_by(uid: session[:user_id]) if session[:user_id]
	end

	def authorize!
    respond_to do |format|
      format.html {redirect_to "/auth/auth0" unless current_user}
      format.js { (render :js => "window.location = '/auth/auth0'") unless current_user}
    end
  end

  def signed_in?
    !!current_user
  end

  def set_current_user(user)
    @current_user = user
    session[:user_id] = user.nil? ? nil : user.uid
  end
end

# Omniauth auth0 controller
#
# Source:: https://auth0.com/docs/quickstart/webapp/rails/01-login#install-the-dependencies
# Implementer(11/27/17):: Stephen

class Auth0Controller < ApplicationController
  #Called after successful auth
  def callback
    if request.env['omniauth.auth']
      @user = User.find_or_create_from_auth(request.env['omniauth.auth'])
      if @user
        set_current_user @user
        redirect_to user_path(@user)
      else
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  #Logout
  def destroy
    current_user = nil
    session.delete(:user_id)
    redirect_to root_path
  end
  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
    redirect_to root_path
  end
end

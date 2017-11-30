# Omniauth auth0 controller
#
# Source:: https://auth0.com/docs/quickstart/webapp/rails/01-login#install-the-dependencies
# Implementer(11/27/17):: Stephen

class Auth0Controller < ApplicationController
  #Controller action that is called after a successful authentication.
  #Sets the current user to the one that just logged in and redirects to their profile.
  # GET /auth/oauth2/callback
  #
  # Author: Stephen
  def callback
    # Check if we recieved a hash variable from omniauth. If not, redirect to index.
    if request.env['omniauth.auth']
      # Use the omniauth values to either find or create a user
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

  #Controller action that is called after the user clicks the logout button
  # GET /logout
  #
  # Author: Nishad
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

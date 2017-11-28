# Omniauth auth0 controller
# Source:: https://auth0.com/docs/quickstart/webapp/rails/01-login#install-the-dependencies
# Implementer(11/27/17):: Stephen

class Auth0Controller < ApplicationController
  def callback
    # This stores all the user information that came from Auth0
    # and the IdP
    session[:userinfo] = request.env['omniauth.auth']
    # Redirect to the URL you want after successful auth
    redirect_to '/wallpapers'
  end

  def failure
    # show a failure page or redirect to an error page
    @error_msg = request.params['message']
  end
end

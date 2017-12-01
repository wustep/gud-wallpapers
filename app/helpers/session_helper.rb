# Session_Helper
#
# Reference:: https://auth0.com/docs/quickstart/webapp/rails/01-login#install-the-dependencies
# Author(11/27/17):: Stephen

module SessionHelper
  # Set session to state obtained from omniauth
  # Session is used to obtain Auth0 user info
  # Author:: Stephen
  def get_state
    state = SecureRandom.hex(24)
    session['omniauth.state'] = state
    state
  end
end

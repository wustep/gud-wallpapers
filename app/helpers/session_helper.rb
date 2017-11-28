# Session_Helper
#
# Source:: https://auth0.com/docs/quickstart/webapp/rails/01-login#install-the-dependencies
# Implementer(11/27/17):: Stephen

module SessionHelper
  def get_state
    state = SecureRandom.hex(24)
    session['omniauth.state'] = state
    state
  end
end

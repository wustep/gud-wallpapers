# Omniauth logout controller
# Source:: https://auth0.com/docs/quickstart/webapp/rails/01-login#install-the-dependencies
# Implementer(11/27/17):: Stephen

class LogoutController < ApplicationController
  include LogoutHelper
  def logout
    reset_session
    redirect_to logout_url.to_s
  end
end

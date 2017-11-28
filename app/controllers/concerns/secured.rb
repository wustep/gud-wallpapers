# Secured concern to check if user is authenticated, otherwise redirect to root
#
# Source:: https://auth0.com/docs/quickstart/webapp/rails/01-login
# Implemented(11/27/17):: Stephen

module Secured
  extend ActiveSupport::Concern

  included do
    before_action :logged_in_using_omniauth?
  end

  def logged_in_using_omniauth?
    redirect_to '/' unless session[:userinfo].present?
  end
end

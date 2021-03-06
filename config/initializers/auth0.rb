# Omniauth initializers
#
# Reference:: https://auth0.com/docs/quickstart/webapp/rails/01-login#install-the-dependencies
# Author(11/27/17):: Stephen

# Be sure to restart your server when you modify this file.

# Load middleware for OmniAuth with Auth0 as provider, using secrets.yml config vars
Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    Rails.application.secrets.auth0_client_id,
    Rails.application.secrets.auth0_client_secret,
    Rails.application.secrets.auth0_client_domain,
    callback_path: "/auth/oauth2/callback",
    authorize_params: {
      scope: 'openid profile',
      audience: 'https://' + Rails.application.secrets.auth0_client_domain + '/userinfo'
    }
  )
end

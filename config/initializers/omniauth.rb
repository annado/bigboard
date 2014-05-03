Rails.application.config.middleware.use OmniAuth::Builder do
  provider :yammer, Rails.application.secrets.yammer_api_key, Rails.application.secrets.yammer_api_secret, {
    :provider_ignores_state => true
  }
end
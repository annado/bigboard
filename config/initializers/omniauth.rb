Rails.application.config.middleware.use OmniAuth::Builder do
  provider :yammer, Rails.application.secrets.yammer_api_key, Rails.application.secrets.yammer_api_secret
end
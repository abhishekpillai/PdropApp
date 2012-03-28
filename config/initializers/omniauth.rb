Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['PdropApp_TWITTER_KEY'], ENV['PdropApp_TWITTER_SECRET']
  provider :facebook, ENV['PdropApp_FACEBOOK_KEY'], ENV['PdropApp_FACEBOOK_SECRET'], :scope => 'email,offline_access,publish_stream', :display => 'popup'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
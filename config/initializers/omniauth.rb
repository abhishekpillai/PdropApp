Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'oufoklXgcH2CDPkx3YQIvw', 'wZqTlgJlSXDozZrhuSwRo08PmRRQxGs5v1h30nZjE'
  # provider :facebook, 'APP_ID', 'APP_SECRET'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
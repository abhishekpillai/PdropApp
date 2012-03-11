Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'oufoklXgcH2CDPkx3YQIvw', 'wZqTlgJlSXDozZrhuSwRo08PmRRQxGs5v1h30nZjE'
  provider :facebook, '224267607670777', '235b57019c7a55a14025972719dafc5b', :scope => 'email,offline_access,publish_stream', :display => 'popup'
  # provider :linked_in, 'CONSUMER_KEY', 'CONSUMER_SECRET'
end
OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, 'client_id', 'client_secret',
           {
               :scope => ['email', 'profile', 'https://www.googleapis.com/auth/androidpublisher'],
               :access_type => 'offline'
           }
  # OmniAuth.config.on_failure = SessionsController.action(:oauth_failure)
end
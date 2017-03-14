OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  OmniAuth.config.full_host = Rails.env.production? ? 'https://oauth-example.herokuapp.com' : 'http://localhost:3000'
  provider :google_oauth2, 'client_id', 'client_secret',
           {
               :scope => ['https://www.googleapis.com/auth/userinfo.email', 'https://www.googleapis.com/auth/userinfo.profile', 'https://www.googleapis.com/auth/androidpublisher'],
               :access_type => 'offline'
           }
  # OmniAuth.config.on_failure = SessionsController.action(:oauth_failure)
end
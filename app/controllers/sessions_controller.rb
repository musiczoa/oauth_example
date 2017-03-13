class SessionsController < ApplicationController
  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    # @auth = request.env['omniauth.auth']['credentials']
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  # def oauth_failure
  #   # Retrieve the error
  #   @error = request.env['omniauth.error']
  #
  #   # Render a json error template
  #   render 'create_fail', status: 401
  # end
end

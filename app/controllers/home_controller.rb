require 'net/https'

class HomeController < ApplicationController
  include HTTParty
  PACKAGE_NAME = 'package.name'
  def show
    @token = User.last
    token = User.last.oauth_token
    uri = 'https://www.googleapis.com/androidpublisher/v2/applications/' + PACKAGE_NAME + '/inappproducts'
    @options = { headers: { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
    @list = self.class.get(uri.to_s, @options)
    @view = JSON.pretty_generate(@list)
  end

  def make_developer_payload

  end
end

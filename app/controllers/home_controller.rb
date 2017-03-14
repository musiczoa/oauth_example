require 'net/https'
require 'securerandom'

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
    @uid = SecureRandom.uuid
  end

  def verify_purchase_product
    @token = User.last
    token = User.last.oauth_token
    product_id = request[:product_id]
    purchase_token = request[:purchase_token] # from client
    uri = 'https://www.googleapis.com/androidpublisher/v2/applications/' + PACKAGE_NAME + '/purchases/products/' + product_id + '/tokens/' + purchase_token
    @options = { headers: { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
    @list = self.class.get(uri.to_s, @options)
    # @view = JSON.pretty_generate(@list)
  end
end

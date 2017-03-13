require 'test_helper'
require 'securerandom'

class HomeControllerTest < ActionDispatch::IntegrationTest
  include HTTParty
  PACKAGE_NAME = 'package.name'

  test 'access token validation' do
    token = users(:one).oauth_token
    @u = 'https://www.googleapis.com/oauth2/v3/tokeninfo?access_token=' + token
    @result = self.class.get(@u.to_s)
    puts JSON.pretty_generate(@result)
  end

  test 'get inapp product list' do
    token = users(:one).oauth_token
    uri = 'https://www.googleapis.com/androidpublisher/v2/applications/' + PACKAGE_NAME + '/inappproducts'
    @options = { headers: { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
    @result = self.class.get(uri.to_s, @options)
    puts JSON.pretty_generate(@result)
  end

  test 'get inapp product one' do
    token = users(:one).oauth_token
    sku = 'gas'
    uri = 'https://www.googleapis.com/androidpublisher/v2/applications/' + PACKAGE_NAME + '/inappproducts/' + sku
    @options = { headers: { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
    @result = self.class.get(uri.to_s, @options)
    puts JSON.pretty_generate(@result)
  end

  test 'voided purchases get' do
    token = users(:one).oauth_token
    uri = 'https://www.googleapis.com/androidpublisher/v2/applications/' + PACKAGE_NAME + '/purchases/voidedpurchases'
    @options = { headers: { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
    @result = self.class.get(uri.to_s, @options)
    puts JSON.pretty_generate(@result)
  end

  test 'purchases products get' do
    # Checks the purchase and consumption status of an inapp item
    token = users(:one).oauth_token

    product_id = 'gas'

    purchase_token = 'purchase_token'
    uri = 'https://www.googleapis.com/androidpublisher/v2/applications/' + PACKAGE_NAME + '/purchases/products/' + product_id + '/tokens/' + purchase_token
    @options = { headers: { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
    @result = self.class.get(uri.to_s, @options)
    puts JSON.pretty_generate(@result)
  end

  test 'purchases subscriptions get' do
    token = users(:one).oauth_token
    purchase_token = 'purchase_token'
    uri = 'https://www.googleapis.com/androidpublisher/v2/applications/' + PACKAGE_NAME + '/purcahses/subscriptions/infinite_gas_monthly/tokens/' + purchase_token
    @options = { headers: { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
    @result = self.class.get(uri.to_s, @options)

    puts @result
  end

  test 'make developer payload' do
    uid = SecureRandom.uuid
    assert uid.length == 36
  end

  test 'verify developer payload' do
    token = users(:one).oauth_token
    product_id = 'gas'

    purchase_token = 'purchase_token'
    uri = 'https://www.googleapis.com/androidpublisher/v2/applications/' + PACKAGE_NAME + '/purchases/products/' + product_id + '/tokens/' + purchase_token
    @options = { headers: { 'Authorization' => "Bearer #{token}", 'Content-Type' => 'application/json' } }
    @result = self.class.get(uri.to_s, @options)
    puts JSON.pretty_generate(@result)

    # {
    #     "kind": "androidpublisher#productPurchase",
    #     "purchaseTimeMillis": long,
    #     "purchaseState": integer,
    #     "consumptionState": integer,
    #     "developerPayload": string
    # }
  end
end

require 'test_helper'

class MerchantLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @merchant = merchants(:michael)
  end

  test "login with invalid information" do
       get '/merchants/login'
       assert_template 'sessions/new'
       post '/merchants/login', session: { email: "", password: ""}
       assert_template 'sessions/new'
       assert_not flash.empty?
       get '/merchants/login'
       assert flash.empty?, "Temporary session still persists"
  end

  test "login with valid information" do
      get '/merchants/login'
      assert_template 'sessions/new'
      post '/merchants/login', session: { email: @merchant.email, password: @merchant.password_digest}
  end
end

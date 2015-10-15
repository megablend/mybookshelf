require 'test_helper'

class MerchantLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @merchant = merchants(:michael)
    store = stores(:michael)
    @email = "megablendjobs@gmail.com"
    @password = "megacharsy"
  end

  # Return false if the merchant was able to login without valid information
  test "login with invalid information" do
       get '/merchants/login'
       assert_template 'sessions/new'
       post '/merchants/login', session: { email: "", password: ""}
       assert_template 'sessions/new'
       assert_not flash.empty?
       get '/merchants/login'
       assert flash.empty?, "Temporary session still persists"
  end

  # Return false if the merchant was not able to login with valid information
  test "login with valid information" do
      get '/merchants/login'
      assert_template 'sessions/new'
      post '/merchants/login', session: { email: @email, password: @password}
      assert flash.empty?, flash[:danger]
  end
end

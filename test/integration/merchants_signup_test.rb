require 'test_helper'

class MerchantsSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
      get "/merchants/signup"
      assert_no_difference "Merchant.count" do
          post merchants_path, merchant: {firstname: "nonso",
                                          lastname: "megafu",
                                          phone_number: "08060108165",
                                          email: "dhfjfj@gmail.com",
                                          city: "fjfjj",
                                          landmark: "people's club",
                                          state_id: 2,
                                          password: "12345",
                                          password_confirmation: "12345",
                                          terms: "1"}
      end
      assert_template "merchants/new"
  end
end

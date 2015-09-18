require 'test_helper'

class MerchantsSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
      get "merchants/signup"
      assert_no_difference "Merchant.count" do
          post merchants_path, merchant: {firstname: "",
                                          lastname: "",
                                          phone_number: "ggfggff",
                                          email: "dhfjfj@hdhff",
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

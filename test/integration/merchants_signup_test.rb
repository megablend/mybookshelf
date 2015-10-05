require 'test_helper'

class MerchantsSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
      get "/merchants/signup"
      assert_no_difference "Merchant.count", 1 do
          post merchants_path, merchant: {firstname: "nonso",
                                          lastname: "megafu",
                                          phone_number: "08060108165",
                                          email: "dhfjfj@gmail",
                                          city: "fjfjj",
                                          landmark: "people's club",
                                          state_id: 2,
                                          password: "12345",
                                          password_confirmation: "12345",
                                          terms: "1"}
      end

      get "/merchants/signup"

      # confirm if the store details was saved successfully
      assert_no_difference "Store.count", 1 do
         post stores_path, store: { name: "Lasage Ventures",
                                    description: "fhfhfj fjfjfj",
                                    url: "lasage-ventures",
                                    store_type_id: "2",
                                    merchant_id: "5"}
      end
      assert_template "merchants/new"
  end
end

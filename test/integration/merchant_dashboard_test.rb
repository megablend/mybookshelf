require 'test_helper'

class MerchantDashboardTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid logged in merchant" do
      get merchants_path
      assert_redirected_to '/merchants/login'
      follow_redirect!
      assert_template 'sessions/new'
  end
end

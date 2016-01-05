require 'test_helper'

class CartControllerTest < ActionController::TestCase
  test "should get add_book" do
    get :add_book
    assert_response :success
  end

  test "should get add_ebook" do
    get :add_ebook
    assert_response :success
  end

end

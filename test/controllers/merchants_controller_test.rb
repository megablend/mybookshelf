require 'test_helper'

class MerchantsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should verify merchant email address" do
     get (:verify_email, { verification_code: "rXVxbx1mFgqYJx6LJ2LIwZMKiUj35L8ySmh78yZAte1XlA1mps"})
  end

end

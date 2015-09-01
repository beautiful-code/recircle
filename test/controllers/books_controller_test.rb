require 'test_helper'

class BookControllerTest < ActionController::TestCase
  test "should get newbook" do
    get :newbook
    assert_response :success
  end

  test "should get addbook" do
    get :addbook
    assert_response :success
  end

end

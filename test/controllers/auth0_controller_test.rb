require 'test_helper'

class Auth0ControllerTest < ActionController::TestCase

  test "should get callback on successful auth and create a user" do
    request.env['omniauth.auth'] = {
      "provider" => "test",
      "uid" => "testId",
      "info" => {
        "nickname" => "testNick",
        "name" => "testName"
      }
    }
    assert_difference('User.count') do
      get :callback
    end
    assert_redirected_to user_path(User.last)
  end

  test "callback should redirect to home on unsuccesful auth" do
    assert_no_difference('User.count') do
      get :callback
    end
    assert_redirected_to root_url
  end

  test "should get failure and redirect to home" do
    get :failure
    assert_redirected_to root_url
  end

end

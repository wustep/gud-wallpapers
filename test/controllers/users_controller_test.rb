# Test cases for the user controller
#
# Author(11/30/17):: Nishad
require 'test_helper'

class UserControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @controller = UsersController.new
    @current_user = User.last
    session[:user_id] = @current_user.nil? ? nil : @current_user.uid
  end

  test "show successful on logged in user" do
      get :show, id: @current_user
      assert_response :success
  end

  test "unsuccessful on logged out user" do
    @current_user = nil
    session[:user_id] = nil
    get :show, id: User.last
    assert_redirected_to :controller=>"wallpapers", :action =>"index"
  end

  test "unsuccessful on non matching user" do
    get :show, id: User.first
    assert_redirected_to :controller=>"wallpapers", :action =>"index"
  end

  test "correctly shows favorites" do
    get :show, id: @current_user, gallery: 'favorites'
    assert_response :success
    assert_equal @current_user.favorite_wallpapers, assigns(:wallpapers)
  end
  test "correctly shows uploads" do
    get :show, id: @current_user, gallery: 'uploads'
    assert_response :success
    assert_equal @current_user.uploads, assigns(:wallpapers)
  end

  test "defaults to uploads" do
    get :show, id: @current_user
    assert_response :success
    assert_equal @current_user.uploads, assigns(:wallpapers)
  end
end

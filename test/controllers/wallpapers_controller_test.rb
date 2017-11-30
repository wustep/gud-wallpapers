require 'test_helper'

class WallpapersControllerTest < ActionController::TestCase
  setup do
    @wallpaper = wallpapers(:one)
    @current_user = User.last
    session[:user_id] = @current_user.nil? ? nil : @current_user.uid
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wallpapers)
  end

  test "upload should redirect to auth when not logged in" do
    @current_user = nil
    session[:user_id] = nil
    get :new
    assert_redirected_to "/auth/auth0"
  end

  test "get new successful when logged in" do
    get :new
    assert_response :success
  end

  test "should create wallpaper" do
    assert_difference('Wallpaper.count') do
      post :create, wallpaper: { image: fixture_file_upload("files/index.png", "image.png"), title: @wallpaper.title, tag_list: "test1,test2" }
    end

    assert_redirected_to wallpaper_path(assigns(:wallpaper))
  end

  test "should show wallpaper" do
    get :show, id: @wallpaper
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wallpaper
    assert_response :success
  end

  test "should update wallpaper" do
    patch :update, id: @wallpaper, wallpaper: { image: fixture_file_upload("files/index.png", "image.png"), title: @wallpaper.title, tag_list: "test1,test2" }
    assert_redirected_to wallpaper_path(assigns(:wallpaper))
  end

  test "should destroy wallpaper" do
    assert_difference('Wallpaper.count', -1) do
      delete :destroy, id: @wallpaper
    end

    assert_redirected_to wallpapers_path
  end
end

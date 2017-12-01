# Wallpaper controller tests
#
# Author:: Nishad
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

  test "should get index on a search" do
    get :index, {search: "test"}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end

  test "should get index sorted by latest" do
    get :index, {sortOrder: "latest"}
    assert_response :success
    assert_not_nil assigns(:wallpapers)
  end

  test "should get index sorted by top" do
    get :index, {sortOrder: "top"}
    assert_response :success
    assert_not_nil assigns(:wallpapers)
  end

  test "should get index sorted by popular" do
    get :index, {sortOrder: "popular"}
    assert_response :success
    assert_not_nil assigns(:wallpapers)
  end

  test "should get tags" do
    get :tags, {tag: "test1"}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
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
    assert_equal("Wallpaper1", assigns(:wallpaper).title)
    assert_equal(["test2", "test1"], assigns(:wallpaper).all_tags_list)
    assert_redirected_to wallpaper_path(assigns(:wallpaper))
  end

  test "should error on failed create" do
    assert_difference('Wallpaper.count', 0) do
      post :create, wallpaper: { title: @wallpaper.title, tag_list: "test1,test2" }
    end

    assert_response :unprocessable_entity
  end

  test "should show wallpaper" do
    get :show, id: @wallpaper
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wallpaper
    assert_response :success
  end

  test "should update tags" do
    post :create, wallpaper: { image: fixture_file_upload("files/index.png", "image.png"), title: @wallpaper.title, tag_list: "test1,test2" }
    patch :update_tags, id: assigns(:wallpaper), taglist: ["test1", "test2", "test3"], :format => :js
    assert_equal("Wallpaper1", assigns(:wallpaper).title)
    assert_equal(["test3", "test2", "test1"].sort, assigns(:wallpaper).all_tags_list.sort)
    assert_response :success
  end

  test "should update wallpaper" do
    patch :update, id: @wallpaper, wallpaper: { image: fixture_file_upload("files/index.png", "image.png"), title: @wallpaper.title, tag_list: "test1,test2" }
    assert_equal("Wallpaper1", assigns(:wallpaper).title)
    assert_equal(["test2", "test1"], assigns(:wallpaper).all_tags_list)
    assert_redirected_to wallpaper_path(assigns(:wallpaper))
  end

  test "should not destroy wallpaper if not uploader and not mod" do
    @current_user = users(:normal_user)
    session[:user_id] = @current_user.nil? ? nil : @current_user.uid
    assert_difference('Wallpaper.count', 0) do
      delete :destroy, id: @wallpaper
    end

    assert_response :error
  end

  test "should  destroy wallpaper if uploader" do
    @current_user = users(:uploader)
    @wallpaper = wallpapers(:uploaded)
    session[:user_id] = @current_user.nil? ? nil : @current_user.uid
    assert_difference('Wallpaper.count', -1) do
      delete :destroy, id: @wallpaper
    end

    assert_redirected_to wallpapers_url
  end

  test "should  destroy wallpaper if mod" do
    @current_user = users(:mod)
    @wallpaper = wallpapers(:uploaded)
    session[:user_id] = @current_user.nil? ? nil : @current_user.uid
    assert_difference('Wallpaper.count', -1) do
      delete :destroy, id: @wallpaper
    end

    assert_redirected_to wallpapers_url
  end

  test "should favorite" do
    assert_difference('@wallpaper.favorited_by.count', 1) do
      post :favorite, wallpaper_id: @wallpaper.id, format: :js
    end

    assert_response :success
  end

  test "should unfavorite" do
    post :favorite, wallpaper_id: @wallpaper.id, format: :js
    assert_difference('@wallpaper.favorited_by.count', -1) do
      post :unfavorite, wallpaper_id: @wallpaper.id, format: :js
    end

    assert_response :success
  end



end

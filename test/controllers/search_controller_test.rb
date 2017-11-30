# Test cases for the advanced search feature
#
# Author(11/30/17):: Nishad
# Update(11/30/17):: [Martin] Added additional search cases
require 'test_helper'

class SearchControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "get new successful" do
    xhr :get, :new, :format => :js
    assert_response :success
  end

  test "adv_search successful on title" do
    post :adv_search, {title: "Wallpaper1"}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end

  test "adv_search successful on tags" do
    post :adv_search, {tags: "test1"}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end

  test "adv_search successful on width" do
    post :adv_search, {image_width: 40}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end

  test "adv_search successful on height" do
    post :adv_search, {image_height: 20}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end

  test "adv_search successful on title and tag" do
    post :adv_search, {title: "Wallpaper1", tags: "test1"}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end

  test "adv_search successful on title and width" do
    post :adv_search, {title: "Wallpaper1", width: 40}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end

  test "adv_search successful on title and height" do
    post :adv_search, {title: "Wallpaper1", height: 20}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end

  test "adv_search successful on title, width, and height" do
    post :adv_search, {title: "Wallpaper1", width: 40, height: 20}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end

  test "adv_search successful on tag and width" do
    post :adv_search, {tags: "test1", width: 1920}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end

  test "adv_search successful on tag and height" do
    post :adv_search, {tags: "test1", height: 20}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end

  test "adv_search successful on tag, width, and height" do
    post :adv_search, {tags: "test1", width: 40, height: 20}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end

  test "adv_search successful on width and height" do
    post :adv_search, {width: 40, height: 20}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end

  test "adv_search successful on all params" do
    post :adv_search, {title: "Wallpaper1", tags: "test1", image_height: 20, image_width: 40}
    assert_response :success
    assert_not_empty assigns(:wallpapers)
  end
end

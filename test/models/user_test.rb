require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should not save user without provider" do
    user = User.new
    user.uid = "test"
    user.nickname = "test"
    user.email = "test"
    assert_not user.save
  end

  test "should not save user without uid" do
    user = User.new
    user.provider = "test"
    user.nickname = "test"
    user.email = "test"
    assert_not user.save
  end

  test "successfully saves user" do
    user = User.new
    user.uid = "test"
    user.provider = "test"
    user.nickname = "test"
    user.email = "test"
    assert user.save
  end

  test "successfully favorites user" do
    user = User.new
    user.uid = "test"
    user.provider = "test"
    user.nickname = "test"
    user.email = "test"
    user.save

    user.favorite! Wallpaper.first

    assert_equal user.favorite_wallpapers.first, Wallpaper.first
  end

  test "successfully unfavoirtes user" do
    user = User.new
    user.uid = "test"
    user.provider = "test"
    user.nickname = "test"
    user.email = "test"
    user.save

    user.favorite! Wallpaper.first
    assert_equal user.favorite_wallpapers.first, Wallpaper.first
    user.unfavorite! Wallpaper.first

    assert_not_equal user.favorite_wallpapers.first, Wallpaper.first
    assert_empty user.favorite_wallpapers
  end

  test "checks if favorited" do
    user = User.new
    user.uid = "test"
    user.provider = "test"
    user.nickname = "test"
    user.email = "test"
    user.save

    user.favorite! Wallpaper.first

    assert user.favorited? (Wallpaper.first)
  end

  test "checks if favorited false" do
    user = User.new
    user.uid = "test"
    user.provider = "test"
    user.nickname = "test"
    user.email = "test"
    user.save

    assert_not user.favorited? (Wallpaper.first)
  end
end

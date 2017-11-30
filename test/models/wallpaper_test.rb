require 'test_helper'

class WallpaperTest < ActiveSupport::TestCase

  test "should not save wallpaper without title" do
    wallpaper = Wallpaper.new
    assert_not wallpaper.save
  end

  test "should not save wallpaper without image" do
    wallpaper = Wallpaper.new
    wallpaper.title = "test"
    assert_not wallpaper.save
  end

  test "should  save wallpaper image and title" do
    wallpaper = Wallpaper.new
    wallpaper.title = "test"
    wallpaper.image = File.open(fixture_path + "files/index.png")
    assert wallpaper.save
  end

  test "sets priority after save" do
    wallpaper = Wallpaper.new
    wallpaper.title = "test"
    wallpaper.image = File.open(fixture_path + "files/index.png")
    wallpaper.save

    assert wallpaper.priority
  end

  test "saves image dimensions after save" do
    wallpaper = Wallpaper.new
    wallpaper.title = "test"
    wallpaper.image = File.open(fixture_path + "files/index.png")
    wallpaper.save

    assert_equal 225, wallpaper.image_width
    assert_equal 225, wallpaper.image_height
  end

  test "search finds by title" do
    wallpaper = Wallpaper.search("Wallpaper1")
    assert_equal wallpapers(:one), wallpaper.first
    assert_equal 1, wallpaper.length
  end

  test "search finds by tag" do
    wallpaper = Wallpaper.search("test1")
    assert_equal wallpapers(:one), wallpaper.first
    assert_equal 1, wallpaper.length
  end

  test "search finds by incomplete tag" do
    wallpaper = Wallpaper.search("test")
    assert_equal 2, wallpaper.length
  end

  test "adv search finds by title" do
    wallpaper = Wallpaper.adv_search("Wallpaper1")
    assert_equal wallpapers(:one), wallpaper.first
    assert_equal 1, wallpaper.length
  end

  test "adv search finds by tag" do
    wallpaper = Wallpaper.adv_search(nil, "test1")
    assert_equal wallpapers(:one), wallpaper.first
    assert_equal 1, wallpaper.length
  end

  test "adv search finds by height" do
    wallpaper = Wallpaper.adv_search(nil, nil, "20")
    assert_equal wallpapers(:one), wallpaper.first
    assert_equal 1, wallpaper.length
  end

  test "adv search finds by width" do
    wallpaper = Wallpaper.adv_search(nil, nil, nil, "40")
    assert_equal wallpapers(:one), wallpaper.first
    assert_equal 1, wallpaper.length
  end


end

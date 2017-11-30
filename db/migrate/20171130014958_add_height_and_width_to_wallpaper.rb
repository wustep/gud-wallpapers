class AddHeightAndWidthToWallpaper < ActiveRecord::Migration
  def change
    add_column :wallpapers, :image_height, :float
    add_column :wallpapers, :image_width, :float
  end
end

class AddUploadIdToWallpaper < ActiveRecord::Migration
  def change
    add_column :wallpapers, :uploader_id, :integer
  end
end

class AddImpressionsCountToWallpaper < ActiveRecord::Migration
  def change
    add_column :wallpapers, :impressions_count, :int
  end
end

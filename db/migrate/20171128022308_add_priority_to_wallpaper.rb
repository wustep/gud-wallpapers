class AddPriorityToWallpaper < ActiveRecord::Migration
  def change
    add_column :wallpapers, :priority, :float
  end
end

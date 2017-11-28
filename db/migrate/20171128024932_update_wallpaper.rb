class UpdateWallpaper < ActiveRecord::Migration
  def change
    Wallpaper.all.each do |w|
      w.update_attribute :priority, w.get_priority
    end
  end
end

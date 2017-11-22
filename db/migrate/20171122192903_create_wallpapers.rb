class CreateWallpapers < ActiveRecord::Migration
  def change
    create_table :wallpapers do |t|
      t.string :title
      t.attachment :image

      t.timestamps null: false
    end
  end
end

class User < ActiveRecord::Base
  # Association for favorites
  has_many :favorite_wallpapers, :through => :favorites, :source => :favorited, source_type: 'Wallpaper'
  has_many :favorites
  #association for uploads
  has_many :uploads, :class_name => "Wallpaper", :foreign_key => "uploader_id"

  #User can tag photos
  acts_as_tagger

  # creates a new favorite row with post_id and user_id
  def favorite!(wallpaper)
    self.favorites.create!(wallpaper_id: wallpaper.id)
  end

  # destroys a favorite with matching wallpaper_id and user_id
  def unfavorite!(wallpaper)
    favorite = self.favorites.find_by_wallpaper_id(wallpaper.id)
    favorite.destroy!
  end

  # returns true of false if a wallpaper is favorited by user
  def favorited?(wallpaper)
    self.favorites.find_by_wallpaper_id(wallpaper.id)
  end

  # Using omniauth, either finds a user, or, if none found, creates one.
  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid'])

    user.nickname = auth['info']['nickname']
    user.email = auth['info']['name']

    user.save
    user
  end
end

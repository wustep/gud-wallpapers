# User model
#
# Author:: Ben, Nishad
# Update(11/29/17):: [Ben] Added favoriting logic
# Update(11/29/17):: [Jason] Added user ranking logic

class User < ActiveRecord::Base
  # Association for favorites
  has_many :favorite_wallpapers, :through => :favorites, :source => :wallpaper
  has_many :favorites

  # Association for uploads
  has_many :uploads, :class_name => "Wallpaper", :foreign_key => "uploader_id"
  # User can tag photos
  acts_as_tagger

  # Makes sure the the provider and uid from Omniauth is present
  validates :provider, presence: true
  validates :uid, presence: true

  # Favorites a wallpaper
  #
  # Author:: Ben
  def favorite!(wallpaper)
    self.favorites.create!(wallpaper_id: wallpaper.id)
  end

  # Unfavorites a wallpaper
  #
  # Author:: Ben
  def unfavorite!(wallpaper)
    favorite = self.favorites.find_by_wallpaper_id(wallpaper.id)
    favorite.destroy!
  end

  # Checks if a wallpaper is favorited.
  #
  # Author:: Ben
  def favorited?(wallpaper)
    self.favorites.find_by_wallpaper_id(wallpaper.id)
  end

  # Finds or creates a user given Omniauth credentials
  #
  # Author:: Stephen, Nishad
  # Update(11/29/17):: [Jason] Added user rank
  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid'])
    user.nickname = auth['info']['nickname']
    user.email = auth['info']['name']
    unless user.user_rank
      user.user_rank = 1; # Set default rank to 1
    end
    user.save
    user
  end
end

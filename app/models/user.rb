class User < ActiveRecord::Base
  # Association for favorites
  has_many :favorite_wallpapers, :through => :favorites, :source => :wallpaper
  has_many :favorites
  #association for uploads
  has_many :uploads, :class_name => "Wallpaper", :foreign_key => "uploader_id"

  #User can tag photos
  acts_as_tagger

  # Using omniauth, either finds a user, or, if none found, creates one.
  def self.find_or_create_from_auth(auth)
    user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid'])

    user.nickname = auth['info']['nickname']
    user.email = auth['info']['name']

    user.save
    user
  end
end

# Wallpaper model
#
# Author:: Nishad

class Wallpaper < ActiveRecord::Base
  # Association for favorites
  has_many :favorited_by, :through => :favorites, :source => :user
  has_many :favorites
  # Association for uploads
  belongs_to :uploader, :class_name => "User", :foreign_key => "uploader_id"
  # Only pull 28 wallpapers per page
  paginates_per 28
  # Allow wallpapers to be tagged
  acts_as_taggable
  # Allow views to be tracked on wallpapers
  is_impressionable :counter_cache => true
  # Update priority after save
  after_save {self.update_column(:priority, self.get_priority)}
  validates :title, presence: true

  # Wallpapers have images attached to them
  has_attached_file :image, styles: {
    index: "600x600"
  },
  # Path on amazon webserver
  :path => "images/:class/nishad/:style/:id:title.:extension"

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment_presence :image

  # Shortens the url of the image
  Paperclip.interpolates :title  do |attachment, style|
    Digest::MD5.hexdigest(attachment.instance.title)[0..6]
  end

  # Finds wallpapers search term in their titles and tags
  # Author: Martin
  def self.search(search)
    where("title LIKE ?", "%#{search}%") | tagged_with(search, wild:true, any:true)
  end

  # Gets the priority of the image
  def get_priority
    views = self.impressionist_count
    seconds = self.created_at.to_f - 1511147177
    return (views + (seconds / 4500)).round(10)
  end

  #Get name for AWS from path
  def get_aws_name
    self.image.path.split("/").last
  end
end

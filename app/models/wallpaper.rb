class Wallpaper < ActiveRecord::Base
  # Only pull 28 wallpapers per page
  paginates_per 28
  # Allow wallpapers to be tagged
  acts_as_taggable
  # Allow views to be tracked on wallpapers
  is_impressionable :counter_cache => true
  # update priority after save
  after_save {self.update_column(:priority, self.get_priority)}
  # Wallpapers have images attached to them
  has_attached_file :image, styles: {
    index: "600x600"
  },
  # Path on amazon webserver
  :path => "images/:class/nishad/:style/:id:title.:extension"

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  # Shortens the url of the image
  Paperclip.interpolates :title  do |attachment, style|
    Digest::MD5.hexdigest(attachment.instance.title)[0..6]
  end

  # gets the priority of the image
  def get_priority
    views = self.impressionist_count
    seconds = self.created_at.to_f - 1511147177
    return (views + (seconds / 4500)).round(10)
  end
end

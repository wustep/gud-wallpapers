class Wallpaper < ActiveRecord::Base
  paginates_per 28
  acts_as_taggable
  is_impressionable
  has_attached_file :image, styles: {
    index: "600x600"
  },
  :path => "images/:class/nishad/:style/:id:title.:extension"

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  Paperclip.interpolates :title  do |attachment, style|
    Digest::MD5.hexdigest(attachment.instance.title)[0..6]
  end
end

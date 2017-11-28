class Wallpaper < ActiveRecord::Base
  paginates_per 28
  acts_as_taggable
  is_impressionable :counter_cache => true
  has_attached_file :image, styles: {
    index: "600x600"
  },
  :path => "images/:class/nishad/:style/:id:title.:extension"

  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

  Paperclip.interpolates :title  do |attachment, style|
    Digest::MD5.hexdigest(attachment.instance.title)[0..6]
  end

  def get_priority
    views = self.impressionist_count
    order = Math.log10([views, 1].max)
    seconds = self.created_at.to_f - 1511147177
    return (order + seconds / 45).round(10)
  end
end

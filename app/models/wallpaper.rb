# Wallpaper model
#
# Author:: Nishad
# Update(11/29/17):: [Martin] Added advanced search method

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
  after_post_process :save_image_dimensions
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  validates_attachment_presence :image

  # Shortens the url of the image
  Paperclip.interpolates :title  do |attachment, style|
    Digest::MD5.hexdigest(attachment.instance.title)[0..6]
  end

  # Finds wallpapers search term in their titles and tags
  #
  # Author:: Martin
  def self.search(search)
    where("title LIKE ?", "%#{search}%") | tagged_with(search, wild:true, any:true)
  end

  # Searches using multiple search terms
  #
  # Author:: Martin
  def self.adv_search(title, tags = nil, image_height = nil, image_width = nil)

    if !title.nil?
      results = where("title LIKE ?", "%#{title}%")
    end
    if !tags.nil? && !tags.empty?
      results = results & tagged_with(tags, wild:true)
    end
    if !image_height.nil? && !image_height.empty?
      results = results & where("image_height IS ?", "%#{image_height}")
    end
    if !image_width.nil? && !image_width.empty?
      results = results & where("image_width IS ?", "%#{image_width}")
    end
    results
  end

  # Gets the priority of the image
  #
  # Author:: Nishad
  def get_priority
    views = self.impressionist_count
    seconds = self.created_at.to_f - 1511147177
    return (views + (seconds / 4500)).round(10)
  end

  #Get name for AWS from path
  #
  # Author:: Nishad
  def get_aws_name
    self.image.path.split("/").last
  end

  def save_image_dimensions
    geo = Paperclip::Geometry.from_file(image.queued_for_write[:original])
    self.image_width = geo.width
    puts self.image_height
    self.image_height = geo.height
  end

end

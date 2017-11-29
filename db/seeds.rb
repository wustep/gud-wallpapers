# Record creation to seed database with default values, scraping reddit
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Author(11/11/17):: Ben

require 'redd'
require 'open-uri'

session = Redd.it(
  user_agent: 'Redd:GudWallpapers:v1.0 (by /u/GudWallpapers)',
  client_id:  'uT7FKbPTbho2aw',
  secret:     'zA91Jzp3FCbxOCu3NUeLlP7oW80',
  username:   'GudWallpapers',
  password:   '#fuckOUAB'
)

# Characters to trim from image names
@garbage_chars = '\/'
# Cutoff for score of images to download
@score_cutoff = 0

# Determine if a post is valid
# Author:: Ben(11/12/17)
def isValid?(post)
  # Check for high enough score
  if post.score < @score_cutoff
    return false
  # Check for existence of image
  elsif File.file?("../img/" + post.title)
    return false
  # Check that the post derectly links to an image
  elsif !post.url.end_with?(".jpg", "jpeg", ".gif", ".png", ".tif", ".tiff")
    puts post.url + " is not valid."
    return false
  end
  true
end
i = 0
reddit = User.find_or_create_by(id: 1)
reddit.nickname = "Reddit"
reddit.save
session.my_subreddits('subscriber').each do |subreddit|
  # Iterate through top posts of the week on the account's front page
  subreddit.top(:time => :day, :limit => 10).each do |post|
    title = post.title
    puts i.to_s + ". " + title
    i = i + 1
    # Trim troublesome characters
    title.tr!(@garbage_chars, '')
    # Try to get the image if the post is valid
    if isValid? post
        puts post.url
        # Open and download the image
        wp = Wallpaper.new
        wp.title = post.title
        wp.image = post.url
        wp.set_owner_tag_list_on(reddit, :tags, subreddit.title)
        wp.save
      # Catch page loading errors
    end
  end
end

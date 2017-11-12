# Reddit wallpaper scraper
#
# Author:: Ben(11/11/17)

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
@score_cutoff = 10000

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
    return false
  end
  true
end

# Iterate through top posts of the week on the account's front page
session.front_page.top(:time => :week).each do |post|
  title = post.title
  # Trim troublesome characters
  title.tr!(@garbage_chars, '')
  # Try to get the image if the post is valid
  if isValid? post
    begin
      # Open and download the image
      open(post.url) {|f|
        File.open("../img/" + title,"wb") do |file|
          file.puts f.read
        end
      }
    # Catch page loading errors
    rescue
      @error_message = "Unable to get file: " + title
      puts @error_message
    end
  end
end

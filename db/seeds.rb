# Record creation to seed database with default values, scraping reddit
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Author(11/11/17):: Ben
# Update(11/29/17):: [Stephen] Revised to use secrets.yml instead of hard-coded values

require 'redd'
require 'open-uri'

# Create session from config vars from secrets.yml
session = Redd.it(
  user_agent: Rails.application.secrets.reddit_user_agent,
  client_id:  Rails.application.secrets.reddit_client_id,
  secret:     Rails.application.secrets.reddit_client_secret,
  username:   Rails.application.secrets.reddit_username,
  password:   Rails.application.secrets.reddit_password
)

# Characters to trim from image names
@garbage_chars = '\/'
# Cutoff for score of images to download
@score_cutoff = 0
# Image file types
@image_types = [".jpg", "jpeg", ".gif", ".png", ".tif", ".tiff"]

# Scrape wallpapers
# Author:: Ben(11/12/17)
# Update(11/29/17):: [Nishad] Added tags to database
# Update(11/29/17):: [Stephen] Changed tags to use subreddit name instead of title
# Update(11/29/17):: [Nishad, Stephen] Improved debug info, added rescue from 404
puts "\r\n[Scraping from subscribed subreddits]"
i = 0
reddit = User.find_or_create_by(id: 1)
reddit.nickname = "Reddit"
reddit.save
session.my_subreddits('subscriber').each do |subreddit|
  # Iterate through top posts of the week on the account's front page
  subreddit.top(:time => :day, :limit => 10).each do |post|
    title = post.title
    i = i + 1
    puts "\r\n" + i.to_s + ". " + title
    # Trim troublesome characters
    title.tr!(@garbage_chars, '')
    # Try to get the image if the post is valid
    begin
      if !@image_types.any? {|extension| post.url.end_with? extension} && !post.is_self
        url = post.url + ".jpg"
      else
        url = post.url
      end
      if !post.is_self
          # Open and download the image
          wp = Wallpaper.new
          wp.title = post.title
          wp.image = url
          wp.set_owner_tag_list_on(reddit, :tags, subreddit.display_name)
          wp.save
          puts post.url + " - added from " + subreddit.display_name
      end
    rescue => error
      puts post.url + " - error: " + error.inspect
    end
  end
end

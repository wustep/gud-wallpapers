require 'redd'
require 'open-uri'

session = Redd.it(
  user_agent: 'Redd:GudWallpapers:v1.0 (by /u/GudWallpapers)',
  client_id:  'uT7FKbPTbho2aw',
  secret:     'zA91Jzp3FCbxOCu3NUeLlP7oW80',
  username:   'GudWallpapers',
  password:   '#fuckOUAB'
)

#Characters to trim from image names
garbage_chars = '\/'
#Cutoff for score of images to download
score_cutoff = 10000

#Iterate through top posts of the week on the account's front page
session.front_page.top(:time => :week).each do |post|
  title = post.title
  #Trim troublesome characters
  title.tr!(garbage_chars, '')
  #Try to get the image if the score is high enough and you don't already have it
  if post.score > score_cutoff && !File.file?("../img/" + title)
    begin
      #Open and download the image
      open(post.url) {|f|
        File.open("../img/" + title,"wb") do |file|
          file.puts f.read
        end
      }
    #Catch page loading errors
    rescue
      @error_message = "Unable to get file: " + title
      puts @error_message
    end
  end
end

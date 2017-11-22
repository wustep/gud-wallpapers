# Project 6
### Ruby on Rails Project
Gud Wallpapers : wallpaper aggregator and sharing service

### Roles
* Overall Project Manager: Stephen
* Coding Manager: Martin
* Testing Manager: Ben
* Documentation: Nishad

### Contributions
* Database Creation: Stephen
* Login/Authorization: Stephen
* Reddit Scraping: Ben
* Image Uploading/Sorting/Tagging: Nishad
* Image Searching/Filtering: Martin
* Image Favoriting/User Gallery/View Count: Jason


##Running Instructions
 1. Go to the root of the project and run `bundle install`
 2. Download imagemagick:
    * Windows: http://imagemagick.sourceforge.net/http/www/windows.html
    * Linux: `sudo apt-get install imagemagick`

 3. Set the AWS config variables in /config/environment/development.rb

 4. Seed the database with the command: `rake db:seed`
 5. Run the server with `rails s`

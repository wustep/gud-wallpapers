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


## Running Instructions
 1. Go to the root of the project and run `bundle install`
 2. Download imagemagick:
    * Windows: http://imagemagick.sourceforge.net/http/www/windows.html
    * Linux: `sudo apt-get install imagemagick`

 3. Setup secrets.yml (more below)
 4. Setup the database with `rake db:reset`
 6. Run the server with `rails s`

## secrets.yml Setup
Paste the following code into /config/secrets.yml and revise the keys accordingly
````
# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure the secrets in this file are kept private
# if you're sharing your code publicly.

development:
  secret_key_base: [SECRET_KEY_BASE_HERE]
  bucket: [BUCKET]
  access_key_id: [ACCESS_KEY_ID]
  secret_access_key: [SECRET_ACCESS_KEY]
  s3_region: [S3 REGION]
test:
  secret_key_base: [SECRET_KEY_BASE]

# Do not keep production secrets in the repository,
# instead read values from the environment.
production:
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
````

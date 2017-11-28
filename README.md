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
* Image Favoriting/View Count: Ben
* Image Uploading/Sorting/Tagging: Nishad
* Image Searching/Filtering: Martin
* User Gallery: Jason


## Running Instructions
 1. Go to the root of the project and run `bundle install`
 2. Download imagemagick:
    * Windows: http://imagemagick.sourceforge.net/http/www/windows.html
    * Linux: `sudo apt-get install imagemagick`

 3. Setup secrets.yml (more below)
 4. Setup the database with `bundle exec rake db:reset`
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

shared: &shared
  aws_bucket: [aws_bucket]
  aws_access_key_id: [aws_access_key_id]
  aws_secret_access_key: [aws_secret_access_key]
  aws_s3_region: [aws_s3_region]
  aws_s3_host_alias: [aws_s3_host_alias]

development:
  <<: *shared
  secret_key_base: [development: secret_key_base]

test:
  <<: *shared
  secret_key_base: [test: secret_key_base]

# Do not keep production secrets in the repository,
# instead read values from the environment.
production:
  <<: *shared
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>
````

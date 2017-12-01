# Project 6
### Ruby on Rails Project
Gud Wallpapers : wallpaper aggregator and sharing service

### Roles
* Overall Project Manager: Stephen
* Coding Manager: Martin
* Testing Manager: Ben
* Documentation: Nishad

### Contributions
* Database Planning/ER Diagram: Stephen
* Login/Authorization: Stephen
* Reddit Scraping: Ben
* Image Favoriting/View Count: Ben
* Image Uploading/Sorting/Tagging: Nishad
* Image Searching/Filtering: Martin
* User Gallery: Jason
* Moderator/Deleting: Jason
* Styling: Nishad, Stephen

## Running Instructions
With Rails 4.2.6 installed:
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
shared: &shared
  aws_bucket: [aws_bucket]
  aws_access_key_id: [aws_access_key_id]
  aws_secret_access_key: [aws_secret_access_key]
  aws_s3_region: [aws_s3_region]
  aws_s3_host_alias: [aws_s3_host_alias]
  auth0_client_domain: [auth0_client_domain]
  auth0_client_id: [auto0_client_id]
  auth0_client_secret: [auth0_client_secret]
  # Reddit scraper agent details
  reddit_user_agent: [reddit_user_agent]
  reddit_client_id: [reddit_client_id]
  reddit_client_secret: [reddit_client_secret]
  reddit_username: [reddit_username]
  reddit_password: [reddit_password]

development:
  <<: *shared
  secret_key_base: [development: secret_key_base]

test:
  <<: *shared
  secret_key_base: [test: secret_key_base]

production:
  <<: *shared
  secret_key_base: <%= ENV["SECRET_KEY_BASE"] %>

# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure the secrets in this file are kept private
# if you're sharing your code publicly.
````
## Testing
**Unit Testing:** Unit tests were written for all of the controllers. In addition, unit tests were written for the user and wallpaper models. These tests can be run by executing the command `rake test` from the root of the project.

**Integration Testing:** Integration testing consisted of monitoring the interactions between the controllers, models, and views. Ensured through extensive use that these interact in an expected manner.

**Systems Testing:** Systems testing was done through browsing the app and using all of its functionality. Make sure that the views are being properly generated and that the different features of the app work as expected.

## Style Guide
**General:**
* Little top level code, most code should be in methods
* 2 space tabs
* Camel case for classes, snake case for variables and functions
* Use blocks as much as possible
* Functions should be short, if function is too big to view without scrolling then separate.
* Classes should represent each entity in the application. 
* Scraper classes should be separate from front end classes.
* Method names should be descriptive and tell the user what they can do without having to look at documentation.
* Use return only when returning in the middle of a function
* Parenthesis only when logic requires it

**Loops:**
* Use little for/while loops, unless when nesting multiple loops
* Use blocks as much as possible

**If/else:**
* If statements that have no else and have only one line after the if should be made into one line
*if/elses that are only one line should be made into one line using the ternary operator
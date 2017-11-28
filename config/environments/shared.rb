# Shared environemnt config for development, production, and test
#
# Update(11/22/17):: [Nishad] Added image uploading paperclip settings for Amazon AWS S3
# Update(11/27/17):: [Stephen] Moved to shared.rb file, since this is shared across all 3 environments

Rails.application.configure do
  # config for amazon S3 and paperclip, method 2 using dotenv direct
  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      :bucket => Rails.application.secrets.aws_bucket,
      :access_key_id => Rails.application.secrets.aws_access_key_id,
      :secret_access_key => Rails.application.secrets.aws_secret_access_key,
      :s3_region => Rails.application.secrets.aws_s3_region
    },
    :url => ':s3_alias_url',
    :s3_host_alias => Rails.application.secrets.aws_s3_host_alias
  }
end

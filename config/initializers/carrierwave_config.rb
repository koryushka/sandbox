CarrierWave.configure do |config|
  config.dropbox_app_key = ENV["APP_KEY"]
  config.dropbox_app_secret = ENV["APP_SECRET"]
  config.dropbox_access_token = ENV["ACCESS_TOKEN"]
  config.dropbox_access_token_secret = ENV["ACCESS_TOKEN_SECRET"]
  config.dropbox_user_id = ENV["USER_ID"]
  config.dropbox_access_type = "dropbox"

  # fog_credentials = {
  #   provider:              'AWS',                        # required
  # }
  #
  # unless Rails.env.development? || Rails.env.test?
  #   fog_credentials[:use_iam_profile] = true
  #   fog_credentials.except! :aws_access_key_id, :aws_secret_access_key
  # end
  #
  # config.fog_credentials = fog_credentials
  # config.fog_directory  = 'cizo-assets'                          # required

end

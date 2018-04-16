Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'ltkLv8Qa7or9nOtLGpA6ubm5T', '5qgOh7CtWz2zVSM4iqor01Mu00ObaN8HBU82Bd86mgf3zUqEpY'
  #provider :twitter, ENV['TWITTER_KEY'], ENV['TWITTER_SECRET']
end
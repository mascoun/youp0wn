# config/initializers/recaptcha.rb
Recaptcha.configure do |config|
  config.site_key  = '6LfdYA4UAAAAAICW6HvtYq1dFN4doPXAn3X1XNWg'
  config.secret_key = '6LfdYA4UAAAAAK7XrI4KZcSCS3hpNGLGuZ3HmbLH'
  # Uncomment the following line if you are using a proxy server:
  #config.proxy = '127.0.0.1:3000'
end
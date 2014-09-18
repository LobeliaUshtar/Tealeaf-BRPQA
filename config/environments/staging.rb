Myflix::Application.configure do

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false

  config.assets.compress = true
  config.assets.js_compressor = :uglifier

  config.assets.compile = false

  config.assets.digest = true

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  config.action_mailer.default_url_options = { host: 'http://lit-dusk-7603.herokuapp.com' }

  ActionMailer::Base.smtp_settings = {
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => "gmail.com",
    :user_name => ENV['GMAIL_SMTP_USER'],
    :password => ENV['GMAIL_SMTP_PASSWORD'],
    :authentification => 'plain',
  }
  
  ActionMailer::Base.delivery_method = :smtp

  config.action_dispatch.show_exceptions = false
end
Myflix::Application.configure do

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.serve_static_assets = false

  config.assets.compress = true
  config.assets.js_compressor = :uglifier

  config.assets.compile = true

  config.assets.digest = true

  config.i18n.fallbacks = true

  config.active_support.deprecation = :notify

  DATABASE_OPERATOR = {
    like_operator: 'ILIKE'
  }

  config.action_mailer.default_url_options = { host: 'http://lit-dusk-7603.herokuapp.com' }

  config.action_mailer.smtp_settings = {
    :address => ENV['smtp_server'],
    :port => ENV['smtp_port'],
    :domain => 'lit-dusk-7603.herokuapp.com',
    :user_name => ENV['smtp_username'],
    :password => ENV['smtp_password'],
    :authentification => 'plain',
  }
  
  ActionMailer::Base.delivery_method = :smtp

  config.action_dispatch.show_exceptions = false
end
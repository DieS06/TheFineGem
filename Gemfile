source "https://rubygems.org"

gem "rails", "~> 7.2.1"
gem "sprockets-rails"
# Use postgresql as the database for Active Record
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

gem "devise"
gem "cancancan"
gem "dotenv-rails", groups: [ :development, :test ]
gem "kaminari"
gem "bootstrap", "~> 5.1"
gem "jquery-rails", "~> 4.4"
gem "dartsass-sprockets"
gem "popper_js"

gem "excon"
gem "calendar_date_select"
gem "notifications_opener"
gem "messaging_gateway"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

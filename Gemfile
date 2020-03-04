source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }
ruby "2.5.1"
gem "rails", "~> 6.0.0.rc2"
gem "mysql2", ">= 0.4.4"
gem "puma", "~> 3.12"
gem "sass-rails", "~> 5"
gem "webpacker", "~> 4.0"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.7"
gem "bootsnap", ">= 1.4.2", require: false
gem "rails-i18n"
gem "bootstrap-sass", "3.3.7"
gem "jquery-rails", "4.3.1"
gem "jquery"
gem "ffaker"
gem "config"
gem "bcrypt",         "3.1.12"
gem "kaminari"
gem "bootstrap-kaminari-views"
gem "font-awesome-sass", "~> 4.7.0"
gem "autonumeric-rails"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 4.0.0.beta2"
  gem "factory_bot_rails"
  gem "capybara", ">= 2.15"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "shoulda-matchers", "~> 3.1"
  gem "database_cleaner"
  gem "guard-rspec"
  gem "rails-controller-testing"
end
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

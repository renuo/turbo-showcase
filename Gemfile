source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(File.join(__dir__, ".ruby-version"))

gem "rails"
gem "bootstrap"
gem "pg"
gem "puma"
gem "importmap-rails"
gem "sass-rails"
gem "standardrb"
gem "view_component"
gem "kaminari"
gem "bootstrap4-kaminari-views"
gem "turbo-rails"
gem "method_source"
gem "stimulus-rails"
gem "redis"
gem "bootsnap", require: false
gem 'appsignal'

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "standard"
end

group :development do
  gem "web-console", ">= 4.1.0"
  gem "listen", "~> 3.3"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

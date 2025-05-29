source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(File.join(__dir__, ".ruby-version"))

gem "rails", "~> 7.1.0"
gem "sqlite3"
gem "solid_cable"

gem "puma"

gem "bootstrap"
gem "dartsass-sprockets"
gem "view_component"
gem "kaminari"
gem "bootstrap4-kaminari-views"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

gem "method_source"

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem "bootsnap", require: false

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

group :production do
  gem "appsignal"
end


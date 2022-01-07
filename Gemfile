source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read(File.join(__dir__, ".ruby-version"))

gem "rails"
gem "pg"
gem "puma"
gem "sass-rails"
gem "standardrb"
gem "webpacker"
gem "view_component", require: "view_component/engine"
gem "kaminari"
gem "bootstrap4-kaminari-views"
gem "turbo-rails"
gem "stimulus-rails"
gem "redis"
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

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]

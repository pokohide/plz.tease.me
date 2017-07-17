source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'
gem 'sinatra', require: false

# Server
gem 'puma', '~> 3.0'

# Image
gem 'aws-sdk', '< 2.0'
gem 'carrierwave'
gem 'fog'
gem 'rmagick', '~> 2.13.1'
# gem 'mini_magick'

# SEO
gem 'meta-tags'
gem 'sitemap_generator'

# Data
gem 'counter_culture', '~> 1.0'
gem 'redis'
gem 'redis-namespace'
gem 'redis-objects'
gem 'sidekiq'
# gem 'dalli'

# PDF Library
gem 'pdfjs_rails'
gem 'poppler'

# Frontend
gem 'gon'
gem 'jquery-rails'
gem 'kaminari'
gem 'slim-rails'
gem 'sprockets-commoner'
# gem 'jquery-ui-rails'
gem 'acts-as-taggable-on', '~> 4.0'
gem 'alertifyjs-rails'
gem 'sass-globbing'
gem 'sass-rails', '~> 5.0'
gem 'semantic-ui-sass', github: 'doabit/semantic-ui-sass'
gem 'uglifier', '>= 1.3.0'

# User
gem 'bcrypt'
gem 'devise'
gem 'omniauth-facebook'
gem 'omniauth-twitter'

# API
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'dotenv-rails'
  gem 'faker'
  gem 'gimei'
  gem 'pry-byebug'
  gem 'pry-doc'
  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'rails-erd'
  gem 'rails_best_practices'
  gem 'scss_lint', require: false
  gem 'sqlite3'
end

group :development do
  gem 'annotate'
  gem 'bullet'
  gem 'letter_opener'
  gem 'listen', '~> 3.0.5'
  gem 'rubocop', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  gem 'brakeman', require: false
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

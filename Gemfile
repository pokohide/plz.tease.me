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

# ENUM
gem 'enum_help'

# SEO
gem 'meta-tags'
gem 'sitemap_generator'

# Data
gem 'acts-as-taggable-on', '~> 4.0'
gem 'counter_culture', '~> 1.0'
gem 'redis'
gem 'redis-namespace'
gem 'redis-objects'
gem 'sidekiq'
# gem 'dalli'

# PDF Library
gem 'poppler', '3.0.8'

# Frontend
gem 'jquery-rails'
gem 'jquery-ui-rails'
gem 'sass-rails', '~> 5.0'
gem 'slim-rails'

# Frontend Library
gem 'alertifyjs-rails'
gem 'kaminari'
gem 'gretel'
gem 'sass-globbing'
gem 'semantic-ui-sass', github: 'doabit/semantic-ui-sass'

# Frontend Utils
gem 'gon'
gem 'sprockets-commoner'
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
  gem 'letter_opener_web'
  gem 'listen', '~> 3.0.5'
  gem 'rubocop', require: false
  gem 'brakeman', require: false
  gem 'scss_lint', require: false
  gem 'bundler-audit'
  gem 'rack-mini-profiler', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  gem 'rails_best_practices'
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.0.2'

# Server
gem 'puma', '~> 3.0'

# Image
gem 'aws-sdk', '< 2.0'
gem 'carrierwave'
gem 'rmagick', '~> 2.13.1'
gem 'fog'
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
gem 'natto'
# gem 'dalli'

# Frontend
gem 'gon'
gem 'kaminari'
gem 'slim-rails'
gem 'sprockets-commoner'
gem 'jquery-rails'
gem 'dropzonejs-rails'
# gem 'jquery-ui-rails'
# gem 'acts-as-taggable-on', '~> 4.0'
gem 'uglifier', '>= 1.3.0'
gem 'sass-rails', '~> 5.0'
gem 'sass-globbing'
gem 'semantic-ui-sass', github: 'doabit/semantic-ui-sass'

# User
gem 'devise'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'bcrypt'

# API
gem 'jbuilder', '~> 2.5'

group :development, :test do
  gem 'sqlite3'
  gem 'byebug', platform: :mri
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-byebug'
  gem 'pry-stack_explorer'
  gem 'rails-erd'
  gem 'scss_lint', require: false
  gem 'faker'
  gem 'gimei'
  gem 'dotenv-rails'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'annotate'
  gem 'letter_opener'
  gem 'rubocop', require: false
  gem 'bullet'
end

group :production do
  gem 'pg'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

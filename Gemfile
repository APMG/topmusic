# frozen_string_literal: true

source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.1'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.3.18', '< 0.5'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'

# Use Makara for load balancing MySQL.
gem 'makara', '~> 0.3.7'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Vendor prefixes for css properties
gem 'autoprefixer-rails'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use requirejs for javascript modules
gem 'erubis'
gem 'requirejs-rails'
# Use jquery as the JavaScript library
gem 'jquery-rails'

# Login
gem 'omniauth', '~> 1.3'
gem 'omniauth-oauth2', '~> 1.4'

# Templating
gem 'slim', '~> 3.0'

# Album art
gem 'colorize'
gem 'musicbrainz', git: 'https://github.com/localhots/musicbrainz.git', branch: 'master'

# Error handling.
gem 'airbrake', '~> 5.0'

gem 'newrelic_rpm', '~> 4.2', group: :production

group :test do
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'pry-stack_explorer'

  gem 'factory_girl_rails'
  gem 'rspec'
  gem 'rspec-rails'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '~> 3.0'
  gem 'web-console'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # Annotate models with fields.
  gem 'annotate'

  # Linter
  gem 'rubocop'

  # Security
  gem 'brakeman'
  gem 'bundler-audit'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

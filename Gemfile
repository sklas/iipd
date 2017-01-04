source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'#, '4.0.2'
gem 'bootstrap-sass'#, '3.0.3.0'

gem 'sqlite3'#, '1.3.8'

# Use sqlite3 as the database for Active Record
group :development, :test do
    gem 'rspec-rails'#, '2.14.0'
    gem 'guard-rspec'#, '4.2.0'
    gem 'spork-rails'#, '4.0.0'
    # gem 'guard-spork', '1.5.1'
    gem 'childprocess'#, '0.3.9'
    gem 'rails-erd'
end
# group :development do
#     gem 'capistrano'
#     gem 'capistrano-bundler'
#     gem 'capistrano-passenger'#, '>= 0.1.1'
#     # Remove the following if your app does not use Rails
#     gem 'capistrano-rails'#
#     # Remove the following if your server does not use RVM
#     gem 'capistrano-rvm'#
# end

# add capybara for testing and libnotify for nice notifications
group :test do
    gem 'selenium-webdriver'#, '2.39.0'
    gem 'capybara'#, '2.2.0'
    gem 'factory_girl_rails'#, '4.2.1'

    gem 'libnotify'#, '0.8.2'
end

# use postgresql for production while using heroku
#group :production do
#    gem 'pg', '0.15.1'
#    gem 'rails_12factor', '0.0.2'
#end

# This is for real production....
group :production do
    gem 'mysql'
    gem 'rails_12factor'
end


# Use squeel for Active record fetching
gem 'squeel'

# Use SCSS for stylesheets
gem 'sass-rails'#, '4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'#, '2.3.3'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'#, '4.0.1'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer'#, platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'#, '3.0.4'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'#, '2.1.0'

# Add jquery-turbolinks to make it possible to get scripts started at link click
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'#, '1.5.3'

# use datatables for browsing proteins. use actual version from Github
gem 'jquery-datatables-rails', '1.12.2'# , github: 'rweng/jquery-datatables-rails', tag: 'v1.12.0'

# will paginate for pagination 
gem 'will_paginate'#, '3.0.5'


group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false#, '0.3.20', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]



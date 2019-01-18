source 'https://rubygems.org'
ruby '2.5.1'

gem 'dotenv-rails', groups: [:development, :test]


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

#sidekiq used for background tasks
gem 'sidekiq', '~> 5.0', '>= 5.0.5'
gem 'sidekiq-status'



group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  gem "rspec-rails"
  gem 'shoulda-matchers', '4.0.0.rc1'
  gem 'rails-controller-testing' 
  gem "rspec-sidekiq"
  gem 'shoulda-callback-matchers', '~> 1.1.1'
  
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

gem "attr_encrypted", "~> 3.0.0"
# gem "aes"
#updated to this repo to fix deprecated warning (warning: constant OpenSSL::Cipher::Cipher is deprecated)
gem 'aes', git: 'https://github.com/jalerson/aes'



source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'rails_12factor'
gem 'heroku-forward'

gem 'will_paginate', '3.0.3'
gem 'bootstrap-will_paginate', '0.0.6'
gem 'jquery-rails'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'simple_form'
gem 'devise'
gem 'figaro'
gem 'whenever', :require => false
gem 'expedia'
gem "koala", '~> 1.8.0rc1'

gem 'jvectormap-rails', '~> 1.0.0'
gem 'geocoder'
gem 'fullcalendar-rails' 
gem 'flot-rails', :git => "https://github.com/Kjarrigan/flot-rails.git"

gem 'carrierwave'
gem 'cloudinary'
gem 'mailgun'

group :development, :test do
  gem 'sqlite3', '1.3.5'
  gem 'rspec-rails', '2.11.0'
  gem 'guard-rspec', '1.2.1'
  gem 'guard-spork', '1.2.0'  
  gem 'spork', '0.9.2'
  gem "nifty-generators"
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '3.2.5'
  gem 'coffee-rails', '3.2.2'
  gem 'uglifier', '1.2.3'
end

group :test do
  gem 'capybara', '1.1.2'
  gem 'factory_girl_rails', '4.1.0'
  gem 'cucumber-rails', '1.2.1', :require => false
  gem 'faker'
end

group :production do
  gem 'pg', '0.12.2'
  gem 'therubyracer-heroku'
end

gem "mocha", :group => :test

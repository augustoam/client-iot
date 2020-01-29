source 'https://rubygems.org'

ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'bcrypt', git: 'https://github.com/codahale/bcrypt-ruby.git', :require => 'bcrypt'
gem 'coffee-rails', '~> 4.2'
gem 'devise'
gem 'devise-i18n'
gem 'dotenv-rails'
gem 'font-awesome-rails'
gem 'fugit'
gem 'gretel'
gem 'jbuilder', '~> 2.5'
gem 'jquery-rails'
gem 'js-routes'
gem 'jwt'
gem 'jwt_sessions'
gem 'materialize-sass'
gem 'materialize-form'
gem 'mqtt', :git => 'https://github.com/njh/ruby-mqtt.git'
gem 'mobylette'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'pundit'
gem 'rack', '<= 2.0.7'
gem 'rack-cors'
gem 'rails', '~> 5.1.2'
gem 'ransack'
gem 'rubocop', require: false
gem 'redis'
gem 'sass-rails', '~> 5.0'
gem 'sidekiq', '>= 6.0'
gem 'sidekiq-scheduler'
gem 'simple_form'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'will_paginate'
gem 'will_paginate-materialize'
gem 'better_errors'
gem 'binding_of_caller'
gem 'htmlbeautifier'
gem 'rails-erd'


group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem 'web-console', '>= 3.3.0'

end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

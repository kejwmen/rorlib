# Load the rails application
require File.expand_path('../application', __FILE__)
Encoding.default_external = "UTF-8"
# Initialize the rails application
PublicRor::Application.initialize!
ENV['RAILS_ENV'] ||= 'development'
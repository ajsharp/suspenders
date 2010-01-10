# Be sure to restart your server when you modify this file

# Change this to the name of your rails project, like carbonrally.  
# Just use the same name as the svn repo.
PROJECT_NAME = "PROJECT_NAME"

throw "The project's name in environment.rb is blank" if PROJECT_NAME.empty?
throw "Project name (#{PROJECT_NAME}) must_be_like_this" unless PROJECT_NAME =~ /^[a-z_]*$/

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.4' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  config.gem 'mislav-will_paginate', :lib => 'will_paginate', :version => '~> 2.3.11'
  config.gem 'authlogic',            :version => '2.1.2'
  config.gem 'haml',                 :version => '2.2.13'
  config.gem 'formtastic',           :version => '0.9.1'
  config.gem 'state_machine',        :version => '0.8.0'
  
  # Run "rake -D time" for a list of tasks for finding time zone names. Uncomment to use default local time.
  config.time_zone = 'UTC'

  #config.action_controller.session_store = :active_record_store

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector
end


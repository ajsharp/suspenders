ENV["RAILS_ENV"] ||= "cucumber"
require File.expand_path(File.dirname(__FILE__) + '/../../config/environment')
require 'cucumber/rails/world'

Cucumber::Rails::World.use_transactional_fixtures = true

ActionController::Base.allow_rescue = false

require 'cucumber'
# Comment out the next line if you don't want Cucumber Unicode support
#require 'cucumber/formatter/unicode'
require 'cucumber/webrat/element_locator' # Lets you do table.diff!(element_at('#my_table_or_dl_or_ul_or_ol').to_table)
require 'cucumber/rails/rspec'

require 'webrat'
require 'webrat/core/matchers' 
Webrat.configure do |config|
  config.mode = :rails
  config.open_error_files = false # Set to true if you want error pages to pop up in the browser
end

require 'pickle/world'


# Example of configuring pickle:
#
# Pickle.configure do |config|
#   config.adapters = [:machinist]
#   config.map 'I', 'myself', 'me', 'my', :to => 'user: "me"'
# end

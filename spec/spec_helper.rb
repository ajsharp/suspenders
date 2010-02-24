ENV["RAILS_ENV"] ||= 'test'
require File.dirname(__FILE__) + "/../config/environment" 
require 'spec/autorun'
require 'spec/rails'
require 'authlogic/test_case' 

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f} 

Spec::Runner.configure do |config|
  include Authlogic::TestCase

  include LoginHelper

  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

end



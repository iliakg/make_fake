ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'database_cleaner'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

### ActiveRecord::Migration.maintain_test_schema! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  FactoryGirl.find_definitions
  config.include ActionDispatch::TestProcess
  config.include FactoryGirl::Syntax::Methods

  config.before(:suite) do
    ### DatabaseCleaner.strategy = :transaction
    ### DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    ### DatabaseCleaner.start
    load('db/seeds.rb')
  end

  config.after(:each) do
    ### DatabaseCleaner.clean
  end


  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"
end

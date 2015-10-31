require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
ENV["RAILS_ENV"] ||= 'test'
RSpec.configure do |config|
    config.include Rails.application.routes.url_helpers
    config.infer_spec_type_from_file_location!
end

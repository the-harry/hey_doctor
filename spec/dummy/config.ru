# This file is used by Rack-based servers to start the application.

require_relative "config/environment"
require "stalker"

map '/_ah/health' do
  run Stalker::Rack::HealthCheck.new
end

run Rails.application
Rails.application.load_server

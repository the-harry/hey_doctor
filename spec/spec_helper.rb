# frozen_string_literal: true

require 'simplecov'
require 'rack/test'
require 'pry'

SimpleCov.start 'rails' do
  add_filter '/bin'
  add_filter '/coverage'
  add_filter '/db'
  add_filter '/lib/hey_doctor/version.rb'
end

SimpleCov.minimum_coverage 95

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end

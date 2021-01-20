# frozen_string_literal: true

class Stalker::Engine < ::Rails::Engine
  isolate_namespace Stalker
  config.generators.api_only = true

  config.generators do |generators|
    generators.test_framework :rspec
  end
end

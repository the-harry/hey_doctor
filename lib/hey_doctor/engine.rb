# frozen_string_literal: true

class HeyDoctor::Engine < ::Rails::Engine
  isolate_namespace HeyDoctor
  config.generators.api_only = true

  config.generators do |generators|
    generators.test_framework :rspec
  end
end

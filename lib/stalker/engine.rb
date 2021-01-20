module Stalker
  class Engine < ::Rails::Engine
    isolate_namespace Stalker
    config.generators.api_only = true
  end
end

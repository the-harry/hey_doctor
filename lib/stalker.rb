# frozen_string_literal: true

require 'stalker/version'
require 'stalker/engine'

module Stalker::Rack
  class HealthCheck
    def call(_env)
      [200, {}, [status]]
    end

    private

    def status
      {
        app: ::Stalker::ApplicationHealth.status,
        database: ::Stalker::DatabaseHealth.status,
        redis: ::Stalker::RedisHealth.status
      }.to_json
    end
  end
end

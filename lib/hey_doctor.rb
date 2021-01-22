# frozen_string_literal: true

require 'hey_doctor/version'
require 'hey_doctor/engine'

module HeyDoctor::Rack
  class HealthCheck
    def call(_env)
      [200, {}, [status]]
    end

    private

    def status
      {
        app: ::HeyDoctor::CheckApplicationHealthService.call,
        database: ::HeyDoctor::CheckDatabaseHealthService.call,
        redis: ::HeyDoctor::CheckRedisHealthService.call
      }.to_json
    end
  end
end

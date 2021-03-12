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
      response = {
        app: ::HeyDoctor::CheckApplicationHealthService.call,
        database: ::HeyDoctor::CheckDatabaseHealthService.call
      }

      unless ENV['REDIS_URL'].blank?
        response.merge!({ redis: ::HeyDoctor::CheckRedisHealthService.call })
      end

      response.to_json
    end
  end
end

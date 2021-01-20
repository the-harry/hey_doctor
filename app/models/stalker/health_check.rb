# frozen_string_literal: true

class Stalker::HealthCheck
  def self.health
    {
      app: Stalker::ApplicationHealth.status,
      database: Stalker::DatabaseHealth.status,
      redis: Stalker::RedisHealth.status
    }.to_json
  end
end

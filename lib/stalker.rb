# frozen_string_literal: true

require 'stalker/version'
require 'stalker/engine'

module Stalker
  def self.health
    {
      app: Stalker::ApplicationHealth.status,
      database: Stalker::DatabaseHealth.status,
      redis: Stalker::RedisHealth.status
    }.to_json
  end
end

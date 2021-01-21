# frozen_string_literal: true

class Stalker::CheckRedisHealthService
  class << self
    SUCCESS = {
      message: 'Redis is connected',
      success: true
    }.freeze

    ERROR = {
      message: 'Error connecting to redis',
      success: false
    }.freeze

    def call
      return SUCCESS if connected?

      ERROR
    end

    private

    def connected?
      Redis.current.get('viva_a_sociedade_alternativa')

      true
    rescue Redis::CannotConnectError, NameError
      false
    end
  end
end

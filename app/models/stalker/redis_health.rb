# frozen_string_literal: true

class Stalker::RedisHealth
  class << self
    SUCCESS = {
      message: 'Redis is connected',
      success: true
    }.freeze

    ERROR = {
      message: 'Error connecting to redis',
      success: false
    }.freeze

    def status
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

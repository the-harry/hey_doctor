# frozen_string_literal: true

class HeyDoctor::CheckRedisHealthService
  class << self
    SUCCESS = {
      success: true,
      message: 'Redis is connected'
    }.freeze

    ERROR = {
      success: false,
      message: 'Error connecting to redis'
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

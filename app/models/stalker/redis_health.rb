# frozen_string_literal: true

class Stalker::RedisHealth
  def self.status
    if connected?
      {
        message: 'Redis is connected',
        success: true
      }
    else
      {
        message: 'Error connecting to redis',
        success: false
      }
    end
  end

  def self.connected?
    Redis.current.get('viva_a_sociedade_alternativa')

    true
  rescue Redis::CannotConnectError, NameError
    false
  end
end

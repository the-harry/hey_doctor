class HealthCheck
  def self.health
    {
      app: ApplicationHealth.status,
      database: DatabaseHealth.status,
      redis: RedisHealth.status
    }.to_json
  end
end

class ApplicationHealth
  def self.status
    {
      message: 'Application is running',
      success: true
    }
  end
end

class DatabaseHealth
  def self.status
    if connected?
      {
        message: 'Database is connected',
        success: true
      }
    else
      {
        message: 'Error connecting to database',
        success: false
      }
    end
  end

  def self.connected?
    ActiveRecord::Base.connection.execute('select 1')

    true
  rescue ActiveRecord::StatementInvalid, ActiveRecord::NoDatabaseError
    false
  end
end

class RedisHealth
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

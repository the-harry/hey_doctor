class HealthCheck
  def self.health
    {
      app: application_status,
      database: database_status,
      redis: redis_status
    }.to_json
  end

  def self.application_status
    {
      message: 'Application is running',
      success: true
    }
  end

  def self.database_status
    if database_connected?
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

  def self.redis_status
    if redis_connected?
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

  def self.database_connected?
    ActiveRecord::Base.connection.execute('select 1')

    true
  rescue ActiveRecord::StatementInvalid, ActiveRecord::NoDatabaseError
    false
  end

  def self.redis_connected?
    Redis.current.get('viva_a_sociedade_alternativa')

    true
  rescue Redis::CannotConnectError, NameError
    false
  end
end

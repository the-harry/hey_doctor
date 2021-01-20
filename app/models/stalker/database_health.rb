# frozen_string_literal: true

class Stalker::DatabaseHealth
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

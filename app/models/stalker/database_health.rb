# frozen_string_literal: true

class Stalker::DatabaseHealth
  class << self
    ERROR = {
      message: 'Error connecting to database',
      success: false
    }.freeze

    SUCCESS = {
      message: 'Database is connected',
      success: true
    }.freeze

    MIGRATION_PENDING = {
      message: 'Pending migrations detected',
      success: true
    }.freeze

    def status
      return ERROR unless connected?
      return MIGRATION_PENDING if needs_migration?

      SUCCESS
    end

    private

    def connected?
      ActiveRecord::Base.connection.execute('select 1')

      true
    rescue ActiveRecord::StatementInvalid, ActiveRecord::NoDatabaseError
      false
    end

    def needs_migration?
      return false unless connected?

      ApplicationRecord.connection.migration_context.needs_migration?
    end
  end
end

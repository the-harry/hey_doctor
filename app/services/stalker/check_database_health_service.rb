# frozen_string_literal: true

class Stalker::CheckDatabaseHealthService
  class << self
    SUCCESS = {
      message: 'Database is connected',
      success: true
    }.freeze

    MIGRATION_PENDING = {
      message: 'Pending migrations detected',
      success: true
    }.freeze

    ERROR = {
      message: 'Error connecting to database',
      success: false
    }.freeze

    def call
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

      ActiveRecord::Base.connection.migration_context.needs_migration?
    end
  end
end

# frozen_string_literal: true

class HeyDoctor::CheckDatabaseHealthService
  class << self
    SUCCESS = {
      success: true,
      message: 'Database is connected'
    }.freeze

    MIGRATION_PENDING = {
      success: true,
      message: 'Pending migrations detected'
    }.freeze

    ERROR = {
      success: false,
      message: 'Error connecting to database'
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

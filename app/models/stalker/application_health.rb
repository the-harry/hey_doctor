# frozen_string_literal: true

class Stalker::ApplicationHealth
  def self.status
    {
      message: 'Application is running',
      success: true
    }
  end
end

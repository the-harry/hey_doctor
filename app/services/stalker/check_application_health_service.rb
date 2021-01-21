# frozen_string_literal: true

class Stalker::CheckApplicationHealthService
  class << self
    SUCCESS = {
      message: 'Application is running',
      success: true
    }.freeze

    ERROR = {
      message: 'Application down, call the firefighters',
      success: false
    }.freeze

    def call
      return SUCCESS if responding?

      ERROR
    end

    private

    def responding?
      Net::HTTP.start('localhost', 8000) { |http| http.head('/') }.code == '200'
    rescue StandardError
      false
    end
  end
end

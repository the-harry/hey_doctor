# frozen_string_literal: true

class HeyDoctor::CheckApplicationHealthService
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
      app_http_code == '200'
    rescue StandardError
      false
    end

    def app_http_code
      port = ENV['RAILS_PORT'] || ENV['PORT']

      Net::HTTP.start('localhost', port) do |http|
        http.head('/_ah/app_health')
      end.code
    end
  end
end

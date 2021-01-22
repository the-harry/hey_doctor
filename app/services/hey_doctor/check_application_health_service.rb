# frozen_string_literal: true

if Rails.version.to_f > 5.0
  require 'rails/commands/server/server_command'
else
  require 'rails/commands/server'
end

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
      Net::HTTP.start('localhost', ENV['RAILS_PORT']) do |http|
        http.head('/_ah/app_health')
      end.code
    end
  end
end

# frozen_string_literal: true

class HeyDoctor::CheckApplicationHealthService
  class << self
    SUCCESS = {
      success: true,
      message: 'Application is running'
    }.freeze

    ERROR = {
      success: false,
      message: 'Application down, call the firefighters'
    }.freeze

    START_COUNTER = 1
    DEFAULT_PORT = ENV['RAILS_PORT'] || ENV['PORT']

    def call
      return SUCCESS if responding?

      ERROR
    end

    private

    def responding?
      app_http_code('localhost', DEFAULT_PORT, START_COUNTER) == 200
    rescue StandardError
      false
    end

    def app_http_code(location, port, retry_counter)
      ssl = port.to_i == 443

      response = Net::HTTP.start(location, port, use_ssl: ssl) do |http|
        http.head('/_ah/app_health')
      end

      return response.code.to_i if retry_counter > 3

      if response.is_a?(Net::HTTPRedirection)
        location = response['location']&.match(/https:\/\/(\w+.\.\w+)\//)

        unless location.nil?
          retry_counter += 1

          return app_http_code(location[1], 443, retry_counter)
        end
      end

      response.code.to_i
    end
  end
end

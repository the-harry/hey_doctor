# frozen_string_literal: true

class HeyDoctor::CheckSidekiqHealthService
  class << self
    SUCCESS = {
      success: true,
      message: 'Sidekiq is connected'
    }.freeze

    ERROR = {
      success: false,
      message: 'Error connecting to sidekiq'
    }.freeze

    NO_EXECUTOR = {
      success: false,
      message: 'None sidekiq host was found, add it to the ENV SIDEKIQ_HOSTS' \
               ' listing your machine(s) ip or dns using  ; for each host'
    }.freeze

    def call
      return NO_EXECUTOR if hosts.blank?

      hosts.map { |host| response(host).merge({ host: host }) }
    end

    private

    def hosts
      @hosts ||= ENV['SIDEKIQ_HOSTS']&.split(';')
    end

    def response(host)
      connected?(host) ? SUCCESS : ERROR
    end

    def connected?(host)
      system("ping -c1 #{host}")
    rescue StandardError
      false
    end
  end
end

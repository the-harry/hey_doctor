# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '.Rack HealthCheck endpoint' do
  let(:expected_response) do
    {
      app: {
        success: true,
        message: 'foo'
      },
      database: {
        success: true,
        message: 'foo'
      },
      redis: {
        success: true,
        message: 'foo'
      },
      sidekiq: [
        {
          success: true,
          message: 'Sidekiq is connected',
          host: 'dcsiloifoodcatalogimporter_sidekiq_1'
        },
        {
          success: false,
          message: 'Error connecting to sidekiq',
          host: 'dcsiloifoodcatalogimporter_sidekiq_2'
        }
      ]
    }.to_json
  end

  let(:env) { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/_ah/health' } }

  before do
    allow(HeyDoctor::CheckApplicationHealthService).to receive(:call)
      .and_return({ message: 'foo', success: true })

    allow(HeyDoctor::CheckDatabaseHealthService).to receive(:call)
      .and_return({ message: 'foo', success: true })

    allow(HeyDoctor::CheckRedisHealthService).to receive(:call)
      .and_return({ message: 'foo', success: true })
  end

  it 'build the json response' do
    response = HeyDoctor::Rack::HealthCheck.new.call(env)
    body = response[2].first

    expect(body).to eq(expected_response)
  end
end

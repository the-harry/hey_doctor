# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '.Rack HealthCheck endpoint' do
  let(:expected_response) do
    {
      app: {
        message: 'foo',
        success: true
      },
      database: {
        message: 'foo',
        success: true
      },
      redis: {
        message: 'foo',
        success: true
      }
    }.to_json
  end

  let(:env) { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/_ah/health' } }

  before do
    allow(Stalker::ApplicationHealth).to receive(:status)
      .and_return({ message: 'foo', success: true })

    allow(Stalker::DatabaseHealth).to receive(:status)
      .and_return({ message: 'foo', success: true })

    allow(Stalker::RedisHealth).to receive(:status)
      .and_return({ message: 'foo', success: true })
  end

  it 'build the json response' do
    response = Stalker::Rack::HealthCheck.new.call(env)
    body = response[2].first

    expect(body).to eq(expected_response)
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Health Check endpoint', type: :request do
  let(:expected_response) do
    {
      app: {
        message: 'Application is running',
        success: true
      },
      database: {
        message: 'Database is connected',
        success: true
      },
      redis: {
        message: 'Redis is connected',
        success: true
      }
    }.to_json
  end

  before { get '/_ah/health' }

  xit 'builds the response' do
    expect(response.body).to eq(expected_response)
  end
end

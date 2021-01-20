require 'rails_helper'

RSpec.describe '.Stalker.health' do
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

  before do
    allow(Stalker::ApplicationHealth).to receive(:status)
      .and_return({ message: 'foo', success: true })

    allow(Stalker::DatabaseHealth).to receive(:status)
      .and_return({ message: 'foo', success: true })

    allow(Stalker::RedisHealth).to receive(:status)
      .and_return({ message: 'foo', success: true })
  end

  it 'build the json response' do
    expect(Stalker.health).to eq(expected_response)
  end
end

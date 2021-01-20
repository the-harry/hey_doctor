require 'rails_helper'

RSpec.describe Stalker::RedisHealth do
  describe '.status' do
    context 'when it is connected' do
      let(:expected_response) do
        {
          message: 'Redis is connected',
          success: true
        }
      end

      it 'respond with success' do
        expect(described_class.status).to eq(expected_response)
      end
    end

    context 'when it is not connected' do
      let(:expected_response) do
        {
          message: 'Error connecting to redis',
          success: false
        }
      end

      before do
        allow(Redis.current).to receive(:get).and_raise(NameError)
      end

      it 'respond with success' do
        expect(described_class.status).to eq(expected_response)
      end
    end
  end

  describe '.connected?' do
    context 'when it is connected' do
      it 'respond with success' do
        expect(described_class.connected?).to eq(true)
      end
    end

    context 'when it is not connected' do
      before do
        allow(Redis.current).to receive(:get)
          .and_raise(Redis::CannotConnectError)
      end

      it 'respond with success' do
        expect(described_class.connected?).to eq(false)
      end
    end
  end
end

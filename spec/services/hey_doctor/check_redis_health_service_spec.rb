# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeyDoctor::CheckRedisHealthService do
  describe '.call' do
    context 'when it is connected' do
      let(:expected_response) do
        {
          success: true,
          message: 'Redis is connected'
        }
      end

      it 'respond with success' do
        expect(described_class.call).to eq(expected_response)
      end
    end

    context 'when it is not connected' do
      let(:expected_response) do
        {
          success: false,
          message: 'Error connecting to redis'
        }
      end

      before do
        allow(Redis.current).to receive(:get).and_raise(NameError)
      end

      it 'respond with success' do
        expect(described_class.call).to eq(expected_response)
      end
    end
  end

  describe '.connected?' do
    context 'when it is connected' do
      it 'respond with success' do
        expect(described_class.send(:connected?)).to eq(true)
      end
    end

    context 'when it is not connected' do
      before do
        allow(Redis.current).to receive(:get)
          .and_raise(Redis::CannotConnectError)
      end

      it 'respond with success' do
        expect(described_class.send(:connected?)).to eq(false)
      end
    end
  end
end

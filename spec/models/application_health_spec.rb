# frozen_string_literal: true

require 'rails_helper'
require 'net/http'

RSpec.describe Stalker::ApplicationHealth do
  describe '.status' do
    let(:http) { double }

    before do
      allow(Net::HTTP).to receive(:start).and_yield(http)

      allow(http).to receive(:head).and_return(response_double)
    end

    context 'When app is running' do
      let(:expected_response) do
        {
          message: 'Application is running',
          success: true
        }
      end

      let(:response_double) { double(Net::HTTP, code: '200') }

      it 'respond with success' do
        expect(described_class.status).to eq(expected_response)
      end
    end

    context 'When app is down' do
      let(:expected_response) do
        {
          message: 'Application down, call the firefighters',
          success: false
        }
      end

      let(:response_double) { double(Net::HTTP, code: '500') }

      it 'respond with success' do
        expect(described_class.status).to eq(expected_response)
      end
    end
  end
end

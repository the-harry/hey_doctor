# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeyDoctor::CheckSidekiqHealthService do
  describe '.call' do
    context 'when it is connected' do
      let(:expected_response) do
        [
          {
            success: true,
            message: 'Sidekiq is connected',
            host: 'dcsiloifoodcatalogimporter_sidekiq_1'
          }
        ]
      end

      before do
        allow(described_class).to receive(:hosts)
          .and_return(['dcsiloifoodcatalogimporter_sidekiq_1'])

        allow(described_class).to receive(:connected?)
          .with('dcsiloifoodcatalogimporter_sidekiq_1').and_return(true)
      end

      it 'respond with success' do
        expect(described_class.call).to eq(expected_response)
      end
    end

    context 'when it is not connected' do
      let(:expected_response) do
        [
          {
            success: false,
            message: 'Error connecting to sidekiq',
            host: 'dcsiloifoodcatalogimporter_sidekiq_2'
          }
        ]
      end

      before do
        allow(described_class).to receive(:hosts)
          .and_return(['dcsiloifoodcatalogimporter_sidekiq_2'])
      end

      it 'respond with error' do
        expect(described_class.call).to eq(expected_response)
      end
    end
  end

  context 'when there is no executor machine' do
    let(:expected_response) do
      {
        success: false,
        message: 'None sidekiq host was found, add it to the ' \
                 'ENV SIDEKIQ_HOSTS listing your machine(s) ip or' \
                 ' dns using  ; for each host'
      }
    end

    before do
      allow(described_class).to receive(:hosts).and_return(nil)
    end

    it 'respond with error' do
      expect(described_class.call).to eq(expected_response)
    end
  end
end

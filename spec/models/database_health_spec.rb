require 'rails_helper'

RSpec.describe Stalker::DatabaseHealth do
  describe '.status' do
    context 'when it is connected' do
      let(:expected_response) do
        {
          message: 'Database is connected',
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
          message: 'Error connecting to database',
          success: false
        }
      end

      before do
        allow(ActiveRecord::Base).to receive(:connection)
          .and_raise(ActiveRecord::StatementInvalid)
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
        allow(ActiveRecord::Base).to receive(:connection)
          .and_raise(ActiveRecord::StatementInvalid)
      end

      it 'respond with success' do
        expect(described_class.connected?).to eq(false)
      end
    end
  end
end

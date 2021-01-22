# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HeyDoctor::CheckDatabaseHealthService do
  describe '.call' do
    context 'when it is connected' do
      let(:expected_response) do
        {
          message: 'Database is connected',
          success: true
        }
      end

      it 'respond with success' do
        expect(described_class.call).to eq(expected_response)
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
        expect(described_class.call).to eq(expected_response)
      end
    end

    context 'When migration is Pending' do
      let(:expected_response) do
        {
          message: 'Pending migrations detected',
          success: true
        }
      end

      before do
        allow(described_class).to receive(:connected?).and_return(true).twice
        allow(described_class).to receive(:needs_migration?).and_return(true)
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
        allow(ActiveRecord::Base).to receive(:connection)
          .and_raise(ActiveRecord::StatementInvalid)
      end

      it 'respond with success' do
        expect(described_class.send(:connected?)).to eq(false)
      end
    end
  end

  describe 'needs_migration?' do
    context 'when migration is Pending' do
      before do
        allow(described_class).to receive(:connected?).and_return(true).twice

        allow(ActiveRecord::Base).to receive_message_chain(
          :connection, :migration_context, :needs_migration?
        ).and_return(true)
      end

      it 'respond with success' do
        expect(described_class.send(:needs_migration?)).to eq(true)
      end
    end
  end
end

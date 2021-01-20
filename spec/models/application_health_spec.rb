# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stalker::ApplicationHealth do
  describe '.status' do
    let(:expected_response) do
      {
        message: 'Application is running',
        success: true
      }
    end

    it 'respond with success' do
      expect(described_class.status).to eq(expected_response)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Health Check endpoint', type: :request do
  context 'When it reaches the internal app_health' do
    before { get '/_ah/app_health' }

    it 'gets internal / that is mounted in /_ah/app_health' do
      expect(response.code).to eq('200')
    end
  end
end

# frozen_string_literal: true

class Stalker::HealthController < Stalker::ApplicationController
  def check
    render :ok, json: Stalker.health
  end
end

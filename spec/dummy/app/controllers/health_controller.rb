class HealthController < ApplicationController
  def check
    render :ok, json: HealthCheck.health
  end
end

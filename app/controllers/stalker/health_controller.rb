class Stalker::HealthController < Stalker::ApplicationController
  def check
    render :ok, json: Stalker::HealthCheck.health
  end
end

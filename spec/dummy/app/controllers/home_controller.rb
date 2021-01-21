class HomeController < ApplicationController
  def index
    render :ok, json: { funfa: 'sim' }
  end
end

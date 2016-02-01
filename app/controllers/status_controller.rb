class StatusController < ApplicationController
  def index
    @latest = StatusEvent.order(updated_at: :desc).take(5)
    @latest_status = StatusEvent.latest_status
  end
end
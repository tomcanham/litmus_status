class StatusEventsController < ApplicationController
  def index
    @latest = StatusEvent.order(updated_at: :desc).take(5)
  end
end
module API
  module V1
    class StatusEventsController < ApplicationController
      def create
        @status_event = StatusEvent.new(status_event_params)

        if @status_event.save
          render json: @status_event
        else
          render json: { message: "Validation error", errors: @status_event.errors }, status: 400
        end
      end

      private
      def status_event_params
        params.permit(:site_down, :message)
      end
    end
  end
end

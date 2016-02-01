require 'rails_helper'

RSpec.describe StatusEventsController, :type => :controller do
  let :events do
    result = [StatusEvent.create!(site_down: false, message: "I am the very model of the modern major general.")]

    6.times do
      result.push(StatusEvent.create!(message: "That's no moon... it's a space station."))
    end

    result
  end

  before do
    events # hydrate the events
  end

  context "#index" do
    it "sets the latest 5 statuses" do
      get :index
      expect(response).to render_template("status_events/index")

      expect(assigns(:latest)).to eq(events[-5..-1]) # last five events
    end

    it "renders the view" do
      StatusEvent.create!(site_down: false, message: "I am the very model of the modern major general.")
      StatusEvent.create!(message: "That's no moon... it's a space station.")

      get :index
      expect(response).to render_template("status_events/index")
    end
  end
end

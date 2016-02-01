require 'rails_helper'

RSpec.describe StatusController, :type => :controller do
  before do
    start = Time.now
    Timecop.freeze(start)

    StatusEvent.create!(site_down: false, message: "That's no moon... it's a space station.")

    6.times do |i|
      Timecop.travel(start + ((i + 1) * 10).seconds)
      StatusEvent.create!(message: "I am the very model of the modern major general.")
    end
  end

  context "#index" do
    it "sets the latest 5 statuses" do
      get :index

      expect(assigns(:latest)).to eq(StatusEvent.order(updated_at: :desc).take(10)) # last ten events
    end

    it "sets the last site up/down status" do
      get :index

      expect(assigns(:latest_status).site_down).to eq(false)
      expect(assigns(:latest_status).message).to eq("That's no moon... it's a space station.")
    end

    it "renders the view" do
      get :index

      expect(response).to render_template("status/index")
    end
  end
end
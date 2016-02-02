require 'rails_helper'

RSpec.describe API::V1::StatusEventsController, :type => :controller do
  context "#create" do
    it "accepts new status events" do
      post :create, {site_down: true, message: "That's no moon... it's a space station."}
      expect(StatusEvent.latest.site_down).to eq(true);
      expect(StatusEvent.latest.message).to eq("That's no moon... it's a space station.");
    end

    it "returns the new model as JSON" do
      post :create, {site_down: true, message: "That's no moon... it's a space station."}

      expect(StatusEvent.count).to eq(1);
      parsed = JSON.parse(response.body)

      expect(parsed["message"]).to eq("That's no moon... it's a space station.")
      expect(parsed["site_down"]).to eq(true)
    end

    it "returns model validation failures" do
      post :create, {}

      expect(StatusEvent.count).to eq(0);
      expect(response.status).to eq(400)
      parsed = JSON.parse(response.body)

      expect(parsed["message"]).to eq("Validation error")
      expect(parsed["errors"]["base"]).to eq(["Must supply either status or message"])
    end

    it "does not require an update to site_down" do
      post :create, {message: "I've got a really bad feeling about this..."}

      expect(StatusEvent.count).to eq(1);
      parsed = JSON.parse(response.body)

      expect(parsed["message"]).to eq("I've got a really bad feeling about this...")
      expect(parsed["site_down"]).to eq(nil)
    end

    it "does not require an update to message" do
      post :create, {site_down: true}

      expect(StatusEvent.count).to eq(1);
      parsed = JSON.parse(response.body)

      expect(parsed["message"]).to eq(nil)
      expect(parsed["site_down"]).to eq(true)
    end
  end
end

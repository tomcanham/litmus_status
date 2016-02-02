require 'rails_helper'

RSpec.describe StatusEvent, :type => :model do
  context "#latest" do
    it "returns the latest event" do
      StatusEvent.create!(site_down: false, message: "Uh, we had a slight weapons malfunction, but uh... everything's perfectly all right now. We're fine. We're all fine here now, thank you. How are you?")
      StatusEvent.create!(site_down: true, message: "That's no moon... it's a space station.")

      expect(StatusEvent.latest.site_down).to eq(true);
      expect(StatusEvent.latest.message).to eq("That's no moon... it's a space station.")
    end
  end

  context "#latest_status" do
    it "returns the latest event with non-nil site_down" do
      good_message = "Uh, we had a slight weapons malfunction, but uh... everything's perfectly all right now. We're fine. We're all fine here now, thank you. How are you?"
      StatusEvent.create!(site_down: false, message: good_message)
      StatusEvent.create!(message: "That's no moon... it's a space station.")

      latest_status = StatusEvent.latest_status
      expect(latest_status.site_down).to eq(false)
      expect(latest_status.message).to eq(good_message)
    end
  end

  context "validations" do
    it "does not require site_down to be set" do
      event = StatusEvent.new(message: "That's no moon... it's a space station.")

      expect(event).to be_valid
    end

    it "does not require message to be set" do
      event = StatusEvent.new(site_down: true)

      expect(event).to be_valid
    end

    it "requires either site_down or message to be set" do
      event = StatusEvent.new()

      expect(event).to_not be_valid
    end
  end
end

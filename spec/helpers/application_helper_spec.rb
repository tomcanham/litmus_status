require "rails_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  describe "#status_to_class" do
    it "returns unknown for a nil status" do
      expect(helper.status_to_class(nil)).to eq("unknown")
    end

    it "returns unknown for a status with a nil site_down" do
      expect(helper.status_to_class(StatusEvent.new(message: "Foo bar"))).to eq("unknown")
    end

    it "returns up for a status with a false site_down" do
      expect(helper.status_to_class(StatusEvent.new(site_down: false, message: "Foo bar"))).to eq("up")
    end

    it "returns down for a status with a true site_down" do
      expect(helper.status_to_class(StatusEvent.new(site_down: true, message: "Foo bar"))).to eq("down")
    end
  end

  describe "#status_to_text" do
    it "returns the same thing as #status_to_class, just upcased" do
      event = StatusEvent.new(message: "Baz bat")
      s_to_c = helper.status_to_class(event)

      expect(helper.status_to_text(event)).to eq(s_to_c.upcase)
    end
  end
end
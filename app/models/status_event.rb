class StatusEvent < ActiveRecord::Base
  validates :message, length: {minimum: 5}

  def self.fake_status
    return self.new(site_down: false, message: "Status not set yet")
  end

  def self.latest
    self.order(updated_at: :desc).first
  end

  def self.latest_status
    self.where.not(site_down: nil).order(updated_at: :desc).first
  end
end

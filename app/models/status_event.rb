class StatusEvent < ActiveRecord::Base
  validates :message, length: {minimum: 5}

  def self.latest
    self.order(updated_at: :desc).first
  end

  def self.latest_status
    self.where.not(site_down: nil).order(updated_at: :desc).first
  end
end

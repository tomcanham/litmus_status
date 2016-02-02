class StatusEvent < ActiveRecord::Base
  validate :must_supply_status_or_message

  def self.latest
    self.order(updated_at: :desc).first
  end

  def self.latest_status
    self.where.not(site_down: nil).order(updated_at: :desc).first
  end

  private
  def must_supply_status_or_message
    if site_down.blank? and message.blank?
      errors[:base] << "Must supply either status or message"
    end
  end
end

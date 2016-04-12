class Event < ActiveRecord::Base
  uuid_it

  validates :name, :available_at, :unavailable_at, presence: true
  validate :sane_dates
  
  scope :available, -> { where("available_at < ?", Time.now).where("unavailable_at > ?", Time.now) }

  def schedule
    "#{self.available_at.strftime("%m/%d/%Y %H:%M")} - #{self.unavailable_at.strftime("%m/%d/%Y %H:%M")}"
  end

  def available?
    self.available_at < Time.now && self.unavailable_at > Time.now
  end

  def past?
    self.available_at < Time.now && self.unavailable_at < Time.now
  end

  private
  def sane_dates
    errors.add(:base, 'invalid dates') if available_at && unavailable_at && available_at > unavailable_at
  end
end

class Event < ActiveRecord::Base
  uuid_it

  has_many :injects
  has_many :inject_responses, through: :injects
  has_many :flag_categories

  validates :name, :available_at, :unavailable_at, presence: true
  validate :sane_dates
  
  scope :available, ->(time=Time.now) { where("? BETWEEN available_at AND unavailable_at", time) }

  default_scope { order('unavailable_at DESC') }

  def self.current
    available.first
  end

  def current?
    self == Event.current
  end

  def self.current_or_most_recent
    order('unavailable_at DESC').first
  end

  def to_s
    name
  end

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

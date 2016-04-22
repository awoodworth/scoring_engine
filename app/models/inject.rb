class Inject < ActiveRecord::Base
  uuid_it
  belongs_to :event
  has_many :inject_responses

  validates :title, :description, :available_at, :due_at, :max_score, :event, :difficulty_level, presence: true
  validates :max_score, numericality: { only_integer: true }
  validates :difficulty_level, inclusion: { in: Setting.difficulty_levels.value.split(',') }

  scope :available, ->(time=Time.now) { joins(:event).where("injects.available_at < ?", time).where("? BETWEEN events.available_at AND events.unavailable_at", time) }
  scope :for_current_event, ->(event=Event.current_or_most_recent) { where(event: event) }
  scope :in_event_order, ->() { joins(:event).order('events.unavailable_at DESC') }

  def to_s
    title
  end

  def available?
    Time.now > self.available_at
  end

  def overdue?
    Time.now > self.due_at
  end

end

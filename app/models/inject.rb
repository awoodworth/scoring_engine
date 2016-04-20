class Inject < ActiveRecord::Base

  belongs_to :event
  has_many :inject_responses

  validates :title, :description, :available_at, :due_at, :max_score, :event, :difficulty_level, presence: true
  validates :max_score, numericality: { only_integer: true }
  validates :difficulty_level, inclusion: { in: Setting.difficulty_levels.value.split(',') }

  scope :available, ->() {where("available_at < ?", Time.now)}

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

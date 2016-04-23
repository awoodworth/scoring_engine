class FlagSubmission < ActiveRecord::Base
  belongs_to :user
  belongs_to :flag
  has_one :flag_category, through: :flag
  has_one :event, through: :flag_category

  validates :user, :flag, :submission_text, presence: true
  validates :correct, inclusion: { in: [true, false] }

  scope :correct, ->(type=true) { where(correct: type) }
  scope :for_current_event, ->(event=Event.current_or_most_recent) { joins(:event).where('events.id = ?', event) }
end

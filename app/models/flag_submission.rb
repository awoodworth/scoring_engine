class FlagSubmission < ActiveRecord::Base
  belongs_to :user
  belongs_to :flag
  has_one :flag_category, through: :flag

  validates :user, :flag, :submission_text, presence: true
  validates :correct, inclusion: { in: [true, false] }

  scope :correct, ->(type=true) { where(correct: type) }
end

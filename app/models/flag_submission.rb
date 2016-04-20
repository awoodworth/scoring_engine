class FlagSubmission < ActiveRecord::Base
  belongs_to :user
  belongs_to :flag
  
  validates :user, :flag, :submission_text, presence: true
  validates :correct, inclusion: { in: [true, false] }
end

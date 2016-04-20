class Flag < ActiveRecord::Base
  uuid_it
  acts_as_tree
  acts_as_list scope: :flag_category
  belongs_to :flag_category
  has_many :flag_submissions

  KINDS = ['text', 'multiple_choice', 'true_false', 'matching', 'multi_part']
  DIFFICULTY_LEVELS = ['easy', 'medium', 'hard', 'expert', 'hacker']

  validates :question, :points, :max_attempts, :kind, :difficulty_level, presence: true
  validates :points, :max_attempts, numericality: { only_integer: true, greater_than: 0 }
  validates :kind, inclusion: { in: KINDS }
  validates :difficulty_level, inclusion: { in: DIFFICULTY_LEVELS }
  serialize :possible_answers, Array

  default_scope { order :position }
end

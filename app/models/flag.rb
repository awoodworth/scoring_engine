class Flag < ActiveRecord::Base
  acts_as_tree
  acts_as_list scope: :flag_category
  belongs_to :flag_category

  KINDS = ['text', 'multiple_choice', 'true_false', 'matching', 'multi_part']

  validates :question, :points, :max_attempts, :kind, presence: true
  validates :points, :max_attempts, numericality: { only_integer: true, greater_than: 0 }
  validates :kind, inclusion: { in: KINDS }
  serialize :possible_answers, Array

  default_scope { order :position }
end

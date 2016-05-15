class FlagCategory < ActiveRecord::Base
  uuid_it
  acts_as_list scope: :event
  belongs_to :event
  has_many :flags
  has_many :flag_submissions, through: :flags

  validates :name, :event, presence: true

  accepts_nested_attributes_for :flags

  default_scope { order :position }
end

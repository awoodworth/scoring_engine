class FlagCategory < ActiveRecord::Base
  uuid_it
  belongs_to :event
  has_many :flags

  validates :name, :event, presence: true

  accepts_nested_attributes_for :flags
end

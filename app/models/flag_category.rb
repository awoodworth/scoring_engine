class FlagCategory < ActiveRecord::Base
  uuid_it

  belongs_to :event

  validates :name, :event, presence: true
end

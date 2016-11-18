class Group < ActiveRecord::Base
  has_many :user_groups, dependent: :destroy
  has_many :users, ->{ uniq }, through: :user_groups

  validates :name, presence: true, uniqueness: true

  def to_s
    self.name
  end
end

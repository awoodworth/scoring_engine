class UserGroup < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  scope :user_in_group_count, ->() { group(:group_id).count }
end

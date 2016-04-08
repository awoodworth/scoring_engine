class User < ActiveRecord::Base

  has_many :user_groups
  has_many :groups, ->{ uniq }, through: :user_groups
  has_many :inject_responses, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: true
  validate :has_at_least_one_group

  scope :in_group, ->(group='blue_team') { joins('RIGHT JOIN user_groups on users.id = user_groups.user_id')
                          .joins('RIGHT JOIN groups on user_groups.group_id = groups.id')
                          .where("groups.name = :group", group: group) }

  default_scope { order('username ASC') }


  def in_group?(group_sym)
    groups.any?{ |group| group.name.underscore.to_sym == group_sym }
  end

  # to override the devise email
  def email_required?
    false
  end
  def email_changed?
    false
  end
  
  private
  def has_at_least_one_group
    errors.add(:base, 'must be in at least one group') if self.user_groups.blank?
  end
end

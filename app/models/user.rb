class User < ActiveRecord::Base

  has_many :inject_responses, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  validates :username, uniqueness: true

  scope :not_admins, ->() {where(admin: false)}

  default_scope { order('username ASC') }

  # to override the devise email
  def email_required?
    false
  end
  def email_changed?
    false
  end
end

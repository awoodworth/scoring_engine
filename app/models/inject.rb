class Inject < ActiveRecord::Base

  has_many :inject_responses

  validates :title, :description, :available_at, :due_at, presence: true

  scope :available, ->() {where("available_at < ?", Time.now)}

  def available?
    Time.now > self.available_at
  end
  def overdue?
    Time.now > self.due_at
  end

end

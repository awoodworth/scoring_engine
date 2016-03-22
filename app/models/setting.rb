class Setting < ActiveRecord::Base
  validates :name, :value, presence: true
  
  def self.service
    where(name: 'service_value').first
  end
  def self.inject
    where(name: 'inject_value').first
  end
end

class Setting < ActiveRecord::Base
  validates :name, :value, presence: true
  
  def self.service_value
    where(name: 'service_value').first
  end
  def self.inject_value
    where(name: 'inject_value').first
  end
  def self.flag_value
    where(name: 'flag_value').first
  end
  def self.inject_show_points
    where(name: 'inject_show_points').first
  end
  def self.flag_show_points
    where(name: 'flag_show_points').first
  end
  def self.inject_default_due_at
    where(name: 'inject_default_due_at').first
  end
  def self.difficulty_levels
    where(name: 'difficulty_levels').first
  end
end

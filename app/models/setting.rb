class Setting < ActiveRecord::Base
  validates :name, :value, presence: true
  validates :name, uniqueness: true

  after_update :reload_classes

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

  private
  # reload_classes is a hack way around loading settings into FINALS
  def reload_classes
    klasses = [:Inject]

    # unload classes
    Object.class_eval do
      klasses.each do |klass|
        remove_const klass.to_s if const_defined? klass.to_s
      end
    end

    # reload classes
    klasses.each do |klass|
      load "#{klass.to_s.underscore}.rb"
    end
  end
end

# Default Settings
Setting.where(name: 'service_value').first_or_create(value: '3')
Setting.where(name: 'inject_value').first_or_create(value: '4')
Setting.where(name: 'flag_value').first_or_create(value: '3')
Setting.where(name: 'inject_show_points').first_or_create(value: 'false')
Setting.where(name: 'flag_show_points').first_or_create(value: 'false')
Setting.where(name: 'inject_default_due_at').first_or_create(value: '0')
Setting.where(name: 'difficulty_levels').first_or_create(value: 'easy,medium,hard,expert,hacker')

# Default Groups
Group.where(name: 'admin').first_or_create
Group.where(name: 'blue_team').first_or_create
Group.where(name: 'red_team').first_or_create
Group.where(name: 'white_team').first_or_create

# Default Admin User
@admin = User.where(username: 'admin').first_or_initialize(password: 'administrator', password_confirmation: 'administrator')
@admin.add_group(:admin)
@admin.save

# Default Teams
1.upto 8 do |i|
  @user = User.where(username: "team-#{i}").first_or_initialize(password: 'password', password_confirmation: 'password')
  @user.add_group(:blue_team)
  @user.save
end

# Default Admin User
User.where(id: 1).first_or_create(username: "admin", password: "administrator", password_confirmation: "administrator")

# Default Groups
Group.where(id: 1).first_or_create(name: 'admin')
Group.where(id: 2).first_or_create(name: 'blue_team')
Group.where(id: 3).first_or_create(name: 'red_team')
Group.where(id: 4).first_or_create(name: 'white_team')

# Default User Group
UserGroup.where(id: 1).first_or_create(user_id: 1, group_id: 1)

# Default Settings
Setting.where(id: 1).first_or_create(name: 'service_value', value: '3')
Setting.where(id: 2).first_or_create(name: 'inject_value', value: '4')
Setting.where(id: 3).first_or_create(name: 'flag_value', value: '3')
Setting.where(id: 4).first_or_create(name: 'inject_show_points', value: 'false')
Setting.where(id: 5).first_or_create(name: 'flag_show_points', value: 'false')
Setting.where(id: 6).first_or_create(name: 'inject_default_due_at', value: '1200')
Setting.where(id: 7).first_or_create(name: 'difficulty_levels', value: 'easy,medium,hard,expert,hacker')

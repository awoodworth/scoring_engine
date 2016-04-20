# Default Admin User
User.create(id: 1, username: "admin", password: "administrator", password_confirmation: "administrator")

# Default Groups
Group.create(id: 1, name: 'admin')
Group.create(id: 2, name: 'blue_team')
Group.create(id: 3, name: 'red_team')
Group.create(id: 4, name: 'white_team')

# Default User Group
UserGroup.create(id: 1, user_id: 1, group_id: 1)

# Default Settings
Setting.create(id: 1, name: 'service_value', value: '0.3')
Setting.create(id: 2, name: 'inject_value', value: '0.4')
Setting.create(id: 3, name: 'flag_value', value: '0.3')
Setting.create(id: 4, name: 'inject_show_points', value: 'true')
Setting.create(id: 5, name: 'flag_show_points', value: 'true')
Setting.create(id: 6, name: 'inject_default_due_at', value: '1200')
Setting.create(id: 7, name: 'difficulty_levels', value: 'easy,medium,hard,expert,hacker')

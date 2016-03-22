# Default Admin User
User.create(username: "admin", password: "administrator", password_confirmation: "administrator", admin: true)

# Default Settings
Setting.create(name: 'service_value', value: '0.6')
Setting.create(name: 'inject_value', value: '0.4')

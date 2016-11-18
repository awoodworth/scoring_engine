100.times do
  @pass = Faker::Internet.password(8)
  @user = User.new(username: Faker::Internet.user_name, password: @pass, password_confirmation: @pass)
  rand(4).times do
    @user.add_group(Group.all.sample.name.to_sym)
  end
  @user.save
end

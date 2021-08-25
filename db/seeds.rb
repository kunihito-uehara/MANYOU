User.create!(
  name: "uekuni", 
  email: "uekuni@dic.com", 
  password: "123456", 
  password_confirmation: "123456",
  admin: true)

10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "123456"
  password_confirmation = "123456"
  User.create!(name: name, email: email,
    password: password, password_confirmation: password_confirmation,
    admin: false)
end

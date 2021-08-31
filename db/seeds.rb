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

10.times do |n|
  Label.create!(
    name: "ラベル#{n + 1}"
  )
end

10.times do |n|
  user_id = n + 1
  Task.create!(
    title: "task#{n + 1}",
    content: "content#{n + 1}",
    expiration_date: "2022-01-01",
    status: "未着手",
    priority: "低",
    user_id: user_id
  )
end

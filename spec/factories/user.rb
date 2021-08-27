FactoryBot.define do #step4
  factory :user do
    name { 'ユーザー1' }
    email { 'user1@dic.com' }
    password { '123456' }
    password_confirmation { '123456' }
    admin { false }
  end
  factory :admin_user, class: User do
    name { 'アドミン1' }
    email { 'admin1@dic.com' }
    password { '123456' }
    password_confirmation { '123456' }
    admin { true }
  end
end
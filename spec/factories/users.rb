FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    login { Faker::Internet.username(specifier: 5..8) }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
  end
end

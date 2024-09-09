FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    id_number { Faker::Number.number(10) }
    phone { Faker::PhoneNumber.cell_phone }
    role { Faker::Number.between(0, 4) }
  end
end

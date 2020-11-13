FactoryBot.define do
  factory :rent do
    cpf { Faker::IDNumber.brazilian_citizen_number }
    start_date { Faker::Date.forward(days: 2)  }
    end_date { Faker::Date.forward(days: 10) }
    vehicle
  end
end

FactoryBot.define do
  factory :rent do
    cpf { Faker::IDNumber.brazilian_id }
    start_date { Faker::Date.between(from: 2.days.ago, to: Date.today)  }
    end_date { Faker::Date.forward(days: 23) }
    vehicle
  end
end

FactoryBot.define do
  factory :vehicle do
    manufacture { Faker::Vehicle.make }
    model { Faker::Vehicle.model(make_of_model: manufacture) }
    license_plate { Faker::Vehicle.license_plate }
    model_year { Faker::Vehicle.year }
    manufacture_year { model_year }
    fuel_type { Faker::Vehicle.fuel_type }
    color { Faker::Vehicle.color }
  end
end

class FipeService
  def self.manufacture(manufacture)
    api_vehicle_type = FipeApi::Vehicle.new(FipeApi::Vehicle::CAR, "Car")
    api_vehicle_type.get_brands.find{|n| n.name == manufacture }
  end

  def self.model(api_manufacture ,model)
    api_manufacture.get_models.find{|n| n.name == model}
  end

  def self.result(api_model, model_year)
    api_year = api_model.get_years.find{|y| y.year == model_year}
    api_year.get_result
  end
end

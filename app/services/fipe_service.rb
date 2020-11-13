class FipeService

  def self.call(manufacture, model, model_year)
    begin
      api_vehicle_type = FipeApi::Vehicle.new(FipeApi::Vehicle::CAR, "Car")
      api_manufacture = api_vehicle_type.get_brands.find {|n| manufacture.include? n.name }

      real_model = api_manufacture.get_models.map {|k| k.name }.find {|y| y.include? model}
      api_model = api_manufacture.get_models.find { |m| m.name == real_model }

      api_year = api_model.get_years.find{|y| y.year == model_year}
      api_year.get_result
    rescue
      return 'incorret params'
    end
  end
end

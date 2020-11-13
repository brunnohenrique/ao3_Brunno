class RentsController < ApplicationController
  def new
    @rent = Rent.new
    set_vehicle(params[:vehicle])
    @rent.vehicle = @vehicle
    respond_with(@rent)
  end

  def create
    return if incorrect_dates
    @rent = Rent.create(rent_params)
    set_vehicle(@rent.vehicle_id)
    respond_with(@rent)
  end

  def show
    @rent = Rent.find(params[:id])
    set_vehicle(@rent.vehicle_id)
    respond_with(@rent)
  end

  private

  def rent_params
    params.require(:rent).permit(%i[cpf start_date end_date vehicle_id])
  end

  def set_vehicle(vehicle_id)
    @vehicle = Vehicle.find(vehicle_id)
  end

  def incorrect_dates
    start_date = rent_params[:start_date].to_date
    end_date = rent_params[:end_date].to_date

    return if start_date < end_date && start_date >= Date.current
      
    redirect_to new_rent_path(vehicle: rent_params[:vehicle_id]), 
      alert: "Please provide valid date values."
  end  
end

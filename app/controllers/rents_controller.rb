class RentsController < ApplicationController
  def new
    @rent = Rent.new
    set_vehicle(params[:vehicle])
    @rent.vehicle = @vehicle
    respond_with(@rent)
  end

  def create
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
end

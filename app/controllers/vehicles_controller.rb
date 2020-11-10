class VehiclesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_vehicle, only: %i[show edit update destroy]

  respond_to :html

  def index
    @vehicles = Vehicle.all
    respond_with(@vehicles)
  end

  def show
    respond_with(@vehicle)
  end

  def new
    @vehicle = Vehicle.new
    respond_with(@vehicle)
  end

  def edit
    respond_with(@vehicle)
  end

  def create
    @vehicle = Vehicle.create(vehicle_params)
    respond_with(@vehicle)
  end

  def update
    @vehicle.update(vehicle_params)
    respond_with(@vehicle)
  end

  def destroy
    @vehicle.destroy
    respond_with(@vehicle)
  end

  private
    def set_vehicle
      @vehicle = Vehicle.find(params[:id])
    end

    def vehicle_params
      params.require(:vehicle).permit(%i[model manufacture license_plate model_year manufacture_year fuel_type color])
    end
end

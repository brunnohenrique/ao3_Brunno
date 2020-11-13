class RentsController < ApplicationController
  def new
    @rent = Rent.new
    @vehicle = Vehicle.find(params[:vehicle])
    @rent.vehicle = @vehicle
    respond_with(@rent)
  end

  def create
    @rent = Rent.create(rent_params)
    respond_with(@rent)
  end  

  private

  def rent_params
    params.require(:rent).permit(%i[cpf start_date end_date])
  end
end

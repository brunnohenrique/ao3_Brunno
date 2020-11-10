class HomeController < ApplicationController
  respond_to :html
  
  def index
    @vehicles = Vehicle.all
    respond_with(@vehicles)
  end
end

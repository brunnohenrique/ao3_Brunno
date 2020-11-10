class HomeController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end
end

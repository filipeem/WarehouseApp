class HomeController < ApplicationController
  def index
    @warehouses = Warehouse.all 
  end

  def search
    @warehouses = Warehouse.where('name like ? OR city like ?',"%#{params[:q]}%", 
                                "%#{params[:q]}%")
  end
end
class HomeController < ApplicationController
  def index
    @warehouses = Warehouse.all 
  end

  def search
    @warehouses = Warehouse.where('name like ? OR city like ?',"%#{params[:q]}%", 
                                "%#{params[:q]}%")
    if @warehouse.nil?
      flash.now[:alert] = "Termo #{params[:q]} não encontrado em Galpões"
    end
  end
end
class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :address, :state, :city,
                                      :postal_code, :description, :useful_area,
                                      :total_area )
    warehouse = Warehouse.new(warehouse_params)
    warehouse.save()
    redirect_to warehouse_path(warehouse.id), notice: 'Galpão registrado com sucesso'
  end
  
end

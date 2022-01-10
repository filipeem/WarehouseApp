class WarehousesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :address, :state, :city,
                                      :postal_code, :description, :useful_area,
                                      :total_area, category_ids: [] )
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save()
        redirect_to warehouse_path(@warehouse.id), notice: 'Galpão registrado com sucesso'
    else
        flash.now[:alert] = 'Não foi possível gravar o galpão'
        render 'new'
    end                               
  end

  def edit
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def update
    @warehouse = Warehouse.find(params[:id])
    warehouse_params = params.require(:warehouse).permit(:name, :code, :address, :state, :city,
                                      :postal_code, :description, :useful_area,
                                      :total_area, category_ids: [] )
    @warehouse.update(warehouse_params)
     
    if @warehouse.errors.any?
      flash.now[:alert] = 'Não foi possível editar o galpão'
      render 'edit'
    else
        redirect_to warehouse_path, notice: 'Galpão editado com sucesso'
    end
   
  end

  def search
    @warehouses = Warehouse.where('name like ? OR city like ?',"%#{params[:q]}%", 
                                "%#{params[:q]}%")
    if @warehouses.empty?
      flash.now[:alert] = "Termo #{params[:q]} não encontrado em Galpões"
    end
  end

  def destroy
    @warehouse = Warehouse.find(params[:id])
    @warehouse.destroy
    redirect_to root_path
  end
  
end

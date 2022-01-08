class Api::V1::WarehousesController < Api::V1::ApiController
  def index
    warehouses = Warehouse.all
    render json: warehouses.as_json(except: [:address, :created_at, :updated_at]), status: 200
  end

  def show
    begin 
      w = Warehouse.find(params[:id])
      render json: w.as_json(except: [:created_at, :updated_at]), status: 200
    rescue ActiveRecord::RecordNotFound
      render json: '{}', status: 404
    end
  end
end
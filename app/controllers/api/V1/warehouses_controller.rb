class Api::V1::WarehousesController < Api::V1::ApiController
  def index
    warehouses = Warehouse.all
    render json: warehouses.as_json(except: [:address, :created_at, :updated_at]), status: 200
  end

  def show
      w = Warehouse.find(params[:id])
      render json: w.as_json(except: [:created_at, :updated_at]), status: 200
  end

  def create
    warehouse_params = params.permit(:name, :code, :description, :postal_code, :address, :city, :state, :total_area, :useful_area)
    w = Warehouse.new(warehouse_params)
    if w.save
      render json: w, status: 201
    else
      render status: 422, json: w.errors.full_messages
    end
  end

end
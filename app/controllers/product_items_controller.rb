class ProductItemsController < ApplicationController
  def show
  end

  def new
    @warehouses = Warehouse.all
    @product_models = ProductModel.all
  end

  def create
    amount = params[:amount].to_i
    warehouse_id = params[:warehouse_id]
    product_model_id = params[:product_model_id]
    price = params[:price].to_i
    batch = params[:batch].to_i

    w = Warehouse.find(warehouse_id)
    pm = ProductModel.find(product_model_id)

    amount.times do 
      ProductItem.create(warehouse: w, product_model: pm, price: price, batch: batch)
    end

    redirect_to w
    
  end
  
end
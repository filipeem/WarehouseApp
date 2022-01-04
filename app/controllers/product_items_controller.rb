class ProductItemsController < ApplicationController
  def show
  end

  def new
    @product_item = ProductItem.new
  end

  def create
    items_amount = params.require(:product_item).permit(:amount)
    product_item_params = params.require(:product_item).permit(:product_model_id, :warehouse_id)
    items_amount[:amount].to_i.times do
      @product_item = ProductItem.new(product_item_params)
      @product_item.save()
    end

    redirect_to warehouse_path(@product_item.warehouse_id), notice: 'Entrada de produtos registrada com sucesso'
    
  end
  
end
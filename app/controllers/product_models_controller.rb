class ProductModelsController < ApplicationController
  def show
    @product_model = ProductModel.find(params[:id])
  end
  
  def new
    @product_model = ProductModel.new
  end
  
  def create
    product_model_params = params.require(:product_model).permit(:name, :sku, :weight,
                                                                 :length, :height, :width,
                                                                 :supplier_id)
    product_model = ProductModel.new(product_model_params)
    if product_model.save()
      redirect_to product_model, notice: 'Modelo de produto registrado com sucesso'
    end
  end

end
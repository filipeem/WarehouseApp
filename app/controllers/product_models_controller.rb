class ProductModelsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  def show
    @product_model = ProductModel.find(params[:id])
  end
  
  def new
    @product_model = ProductModel.new
  end
  
  def create
    product_model_params = params.require(:product_model).permit(:name,  :weight, :length, 
                                                                  :height, :width, :category_id,
                                                                  :supplier_id)
    @product_model = ProductModel.new(product_model_params)
    if @product_model.save()
      redirect_to product_model_path(@product_model.id), notice: 'Modelo de produto registrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível registrar o produto'
      render 'new'
    end
  end

  def edit
    id = params[:id]
    @product_model = ProductModel.find(id)
  end

  def update
    @product_model = ProductModel.find(params[:id])
    product_model_params = params.require(:product_model).permit(:name, :weight, :height, :length, :width,
                                                             :supplier_id, :category_id )
    @product_model.update(product_model_params)
    if @product_model.errors.any?
      flash.now[:alert] = 'Não foi possível editar o produto'
       render 'edit'
    else
      redirect_to product_model_path , notice: 'Produto editado com sucesso' and return
    
    end
  end
end
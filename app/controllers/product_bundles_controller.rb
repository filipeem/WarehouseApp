class ProductBundlesController < ApplicationController
  def show
    id = params[:id]
    @product_bundle = ProductBundle.find(id)
  end

  def new
    @product_bundle = ProductBundle.new
  end

  def create
    bundle_params = params.require(:product_bundle).permit(:name, :sku, product_model_ids: [])
    @product_bundle = ProductBundle.new(bundle_params)
    if @product_bundle.save
      redirect_to product_bundle_path(@product_bundle.id), notice: 'Kit de produto registrado com sucesso'
    else
      flash.now[:alert] = 'Não foi possível registrar o kit de produto'
      render 'new'
    end
  end
end
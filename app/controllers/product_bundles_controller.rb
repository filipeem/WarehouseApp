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
    @product_bundle.save
    redirect_to @product_bundle
  end
end
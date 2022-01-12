class Api::V1::ProductModelsController < Api::V1::ApiController
  def index
    product_models = ProductModel.all
    render json: product_models.as_json(except: [:created_at, :updated_at]), status: 200
  end

  def show
      p = ProductModel.find(params[:id])
      render json: p.as_json(except: [:created_at, :updated_at], methods: [:dimensions], 
                            include: { supplier: { except: [:created_at, :updated_at]} }),
                            status: 200
  end
end
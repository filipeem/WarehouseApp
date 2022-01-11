class SuppliersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :destroy]
  def index
    @suppliers = Supplier.all 
  end

  def show
    id = params[:id]
    @supplier = Supplier.find(id)
  end
  
  def new
    @supplier = Supplier.new
  end

  def create
    supplier_params = params.require(:supplier).permit(:name, :corporate_name, :address, :state, :city,
                                      :cnpj, :email, :phone)
    @supplier = Supplier.new(supplier_params)
    if @supplier.save()
        redirect_to supplier_path(@supplier.id), notice: 'Fornecedor registrado com sucesso'
    else
        flash.now[:alert] = 'Não foi possível gravar o fornecedor'
        render 'new'
    end
  end

  def destroy
    @supplier = Supplier.find(params[:id])
    @supplier.destroy
    redirect_to suppliers_path
  end

end
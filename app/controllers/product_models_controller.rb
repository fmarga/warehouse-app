class ProductModelsController < ApplicationController
  def index
    @product_models = ProductModel.all
  end

  def new
    @product_model = ProductModel.new
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(pm_params)
    
    if @product_model.save
      redirect_to product_models_path, notice: 'Modelo cadastrado com sucesso!'
    else
      @suppliers = Supplier.all
      flash.now[:notice] = 'Não foi possível cadastrar novo modelo'
      render 'new'
    end
  end

  def show
    @product_model = ProductModel.find(params[:id])
  end

  private
  def pm_params
    params.require(:product_model).permit(:name, :weight, :width, :height, :depth, :sku, :supplier_id)
  end
end
class ProductModelsController < ApplicationController
  def index
    @product_models = ProductModel.all
  end

  def new
    @product_models = ProductModel.new
  end

  def create
    @product_models = ProductModel.new(pm_params)
    if @product_models.save
      redirect_to product_models_path, notice: 'Modelo cadastrado com sucesso!'
    else
      flash.now[:notice] = 'Não foi possível cadastrar novo modelo'
      render 'new'
    end
  end

  private
  def pm_params
    params.require(:product_model).permit(:name, :weight, :width, :height, :depth, :sku, :supplier_id)
  end
end
class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update]

  def show; end

  def new
    @warehouse = Warehouse.new
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)

    if @warehouse.save
      redirect_to root_path, notice: "Galpão cadastrado com sucesso!"
    else
      flash.now[:notice] = "Galpão não cadastrado"
      render 'new'
    end
    #strong parameters
    #require - procura a chave dentro do hash de params
    #permit - acessa as chaves dentro da chave utilizada pelo require
  end

  def edit; end

  def update
    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(@warehouse.id), notice: 'Galpão atualizado com sucesso!'
    else
      flash.now[:notice] = 'Não foi possível atualizar o galpão'
      render 'edit'
    end
  end


  #cria um metodo privado, que pode ser acessado pelo proprio controller (não é uma action, então não cria uma rota), para evitar verbosidade
  private
  def set_warehouse
    @warehouse = Warehouse.find(params[:id])
  end

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :area, :address, :postal_code, :description)
  end
end
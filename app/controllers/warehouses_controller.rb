class WarehousesController < ApplicationController
  def show
    id = params[:id]
    @warehouse = Warehouse.find(id)
  end

  def new
    @warehouse = Warehouse.new
  end

  def create
    warehouse_params = params.require(:warehouse).permit(:name, :code, :city, :area, :address, :postal_code, :description)

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
end
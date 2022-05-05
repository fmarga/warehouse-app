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

    w = Warehouse.new(warehouse_params)

    w.save

    #strong parameters
    #require - procura a chave dentro do hash de params
    #permit - acessa as chaves dentro da chave utilizada pelo require

    redirect_to root_path
  end
end
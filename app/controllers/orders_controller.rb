class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end
  
  def new
    @order = Order.new
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.new(order_params)
    @order.user = current_user
    @order.save
    redirect_to @order, notice: 'Pedido registrado com sucesso!'
  end

  def show
    @order = Order.find(params[:id])
    if @order.user != current_user
      redirect_to root_path, notice: 'Acesso negado, não foi possível exibir o pedido'
    end
  end

  def edit
    @order = Order.find(params[:id])
    return redirect_to root_path if @order.user != current_user
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    order_params = params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
    @order = Order.find(params[:id])
    return redirect_to root_path if @order.user != current_user
    @order.update(order_params)

    redirect_to @order, notice: 'Pedido atualizado com sucesso'
  end

  def search
    @code = params[:query]
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end
end
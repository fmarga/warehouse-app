require 'rails_helper'

describe 'Usuário edita um pedido' do
  it 'e não é o dono' do
    tester = User.create!(email: 'tester@email.com', password: 'password')
    user = User.create!(email: 'user@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')
    supplier = Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Outra Empresa', registration_number: '1234567861234', full_address: 'Av. da Empresa, 5000', city: 'São Paulo', state: 'SP', email: 'umaoutraempresa@gmail.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(tester)
    patch(order_path(order.id), params: { order: { supplier_id: 3 } })

    expect(response).to redirect_to root_path
  end
end
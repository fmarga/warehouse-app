require 'rails_helper'

describe 'Usuário edita pedido' do
  it 'e deve estar autenticado' do
    user = User.create!(email: 'user@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')
    supplier = Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Outra Empresa', registration_number: '1234567861234', full_address: 'Av. da Empresa, 5000', city: 'São Paulo', state: 'SP', email: 'umaoutraempresa@gmail.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    visit edit_order_path(order.id)

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user = User.create!(email: 'user@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')
    supplier = Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Outra Empresa', registration_number: '1234567861234', full_address: 'Av. da Empresa, 5000', city: 'São Paulo', state: 'SP', email: 'umaoutraempresa@gmail.com')
    company = Supplier.create!(corporate_name: 'Empresa2 LTDA', brand_name: 'Uma Outra Empresa', registration_number: '1234067861234', full_address: 'Av. da Empresa, 5000', city: 'São Paulo', state: 'SP', email: 'umaoutraempresa@gmail.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Editar'
    fill_in "Data Prevista de Entrega",	with: "12/12/2022" 
    select 'Empresa2 LTDA', from: 'Fornecedor'
    click_on 'Gravar'
    
    expect(page).to have_content 'Pedido atualizado com sucesso'
    expect(page).to have_content 'Fornecedor: Empresa2 LTDA'
    expect(page).to have_content 'Data Prevista de Entrega: 12/12/2022'
  end

  it 'caso seja o responsável' do
    tester = User.create!(email: 'tester@email.com', password: 'password')
    user = User.create!(email: 'user@email.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')
    supplier = Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Outra Empresa', registration_number: '1234567861234', full_address: 'Av. da Empresa, 5000', city: 'São Paulo', state: 'SP', email: 'umaoutraempresa@gmail.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(tester)
    visit edit_order_path(order.id)

    expect(current_path).to eq root_path
  end
end
require 'rails_helper'

describe 'Usuário busca por um pedido' do
  it 'a partir do menu' do
    user = User.create!(email: 'user@gmail.com', password: 'password', name: 'user')

    login_as(user)
    visit root_path

    within('header nav') do
      expect(page).to have_field 'Buscar Pedido'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'e deve estar autenticado' do

    visit root_path

    expect(page).not_to have_field 'Buscar Pedido'
    expect(page).not_to have_button 'Buscar'
  end

  it 'e encontra um pedido' do
    user = User.create!(email: 'user@gmail.com', password: 'password', name: 'user')
    warehouse = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')
    supplier = Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Outra Empresa', registration_number: '1234567861234', full_address: 'Av. da Empresa, 5000', city: 'São Paulo', state: 'SP', email: 'umaoutraempresa@gmail.com')
    order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: order.code
    click_on 'Buscar'

    expect(page).to have_content "Resultados da busca por: #{order.code}"
    expect(page).to have_content '1 pedido encontrado'
    expect(page).to have_content "Código: #{order.code}"
    expect(page).to have_content "Galpão destino: SDU | Galpão do Rio"
    expect(page).to have_content "Fornecedor: Empresa LTDA"
  end

  it 'e encontra múltiplos pedidos' do
    user = User.create!(email: 'user@gmail.com', password: 'password', name: 'user')
    first_warehouse = Warehouse.create!(name: 'Galpão de SP', code: 'GRU', city: 'São Paulo', area: 100_000, address: 'Av. do Porto, 1000', postal_code: '80000-000', description: 'Galpão da cidade de São Paulo')
    second_warehouse = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')
    supplier = Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Outra Empresa', registration_number: '1234567861234', full_address: 'Av. da Empresa, 5000', city: 'São Paulo', state: 'SP', email: 'umaoutraempresa@gmail.com')
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
    order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU98765')
    second_order = Order.create!(user: user, warehouse: first_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('SDU00000')
    third_order = Order.create!(user: user, warehouse: second_warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)

    login_as(user)
    visit root_path
    fill_in 'Buscar Pedido', with: 'GRU'
    click_on 'Buscar'

    expect(page).to have_content '2 pedidos encontrados'
    expect(page).to have_content 'GRU12345'
    expect(page).to have_content 'GRU98765'
    expect(page).to have_content "Galpão destino: GRU | Galpão de SP"
    expect(page).not_to have_content 'SDU00000'
    expect(page).not_to have_content "Galpão destino: SDU | Galpão do Rio"
  end
end
require 'rails_helper'

describe 'Usuário vê seus próprios pedidos' do
  it 'e deve estar autenticado' do

    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq new_user_session_path
  end

  it 'e não vê outros pedidos' do
    first_user = User.create!(email: 'user@email.com', password: 'password')
    second_user = User.create!(email: 'user@gmail.com', password: 'password')
    warehouse = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')
    supplier = Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Outra Empresa', registration_number: '1234567861234', full_address: 'Av. da Empresa, 5000', city: 'São Paulo', state: 'SP', email: 'umaoutraempresa@gmail.com')
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU19345')
    first_order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12345')
    second_order = Order.create!(user: second_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.day.from_now)
    allow(SecureRandom).to receive(:alphanumeric).with(8).and_return('GRU12045')
    third_order = Order.create!(user: first_user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: 1.week.from_now)

    login_as(first_user)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).to have_content first_order.code
    expect(page).not_to have_content second_order.code
    expect(page).to have_content third_order.code
  end
end
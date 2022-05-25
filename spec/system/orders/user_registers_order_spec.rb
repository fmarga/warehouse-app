require 'rails_helper'

describe 'Usuário cadastra um pedido' do

  it 'e deve estar autenticado' do
    visit root_path
    click_on 'Registrar pedido'

    expect(current_path).to eq new_user_session_path
  end

  it 'com sucesso' do
    user = User.create!(name: 'Maria', email: 'maria@email.com', password: 'password')
    maceio = Warehouse.create!(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av. Atlântica, 1000', postal_code: '80000-000', description: 'Galpão da zona portuária de Maceió')
    rio = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')
    company = Supplier.create!(corporate_name: 'Empresa2 LTDA', brand_name: 'Uma Outra Empresa', registration_number: '1234567861234', full_address: 'Av. da Empresa, 5000', city: 'São Paulo', state: 'SP', email: 'umaoutraempresa@gmail.com')
    empresa = Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Empresa', registration_number: 1234567890123, full_address: 'Av. da Empresa, 10', city: 'Porto Alegre', state: 'RS', email: 'emaildaempresa@gmail.com')
    
    visit root_path
    login_as(user)
    click_on 'Registrar pedido'
    select 'SDU | Galpão do Rio', from: 'Galpão Destino'
    select empresa.corporate_name, from: 'Fornecedor'
    fill_in "Data Prevista de Entrega",	with: "20/12/2022" 
    click_on 'Gravar'

    expect(page).to have_content 'Pedido registrado com sucesso!'
    expect(page).to have_content 'Galpão destino: Galpão do Rio'
    expect(page).to have_content 'Fornecedor: Empresa LTDA'
    expect(page).to have_content 'Data Prevista de Entrega: 20/12/2022'
    expect(page).to have_content 'Usuário Responsável: Maria | maria@email.com'
    expect(page).not_to have_content 'Galpão Maceio'
  end
end
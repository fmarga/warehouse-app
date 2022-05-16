require 'rails_helper'

describe 'Usuário vê detalhes de um modelo de produto' do
  it 'e vê informações adicionais' do
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung LTDA', registration_number: 1234567890123, full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'emaildasamsung@gmail.com')
    tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    soundbar = ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZZ770', supplier: supplier)

    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'TV 32'

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'SKU: TV32-SAMSU-XPTO90000'
    expect(page).to have_content 'Fornecedor: Samsung'
    expect(page).to have_content 'Dimensões: 70cm x 45cm x 10cm'
    expect(page).to have_content 'Peso: 8000g'
  end

  it 'e retorna para página de modelos de produtos' do
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung LTDA', registration_number: 1234567890123, full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'emaildasamsung@gmail.com')
    tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    soundbar = ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZZ770', supplier: supplier)

    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'TV 32'
    click_on 'Voltar'

    expect(current_path).to eq product_models_path
    expect(page).to have_content 'Modelos de Produtos'
  end
end
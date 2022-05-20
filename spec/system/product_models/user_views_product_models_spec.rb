require 'rails_helper'

describe 'Usuário vê modelos de produtos' do

  it 'se estiver autenticado' do

    visit root_path
    within('.nav') do
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq new_user_session_path
  end

  it 'a partir do menu' do
    user = User.create!(name: 'Marga', email: 'marga@gmail.com', password: 'password')

    login_as(user)
    visit root_path
    within('.nav') do
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do
    user = User.create!(name: 'Marga', email: 'marga@gmail.com', password: 'password')
    supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung LTDA', registration_number: 1234567890123, full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'emaildasamsung@gmail.com')
    tv = ProductModel.create!(name: 'TV 32', weight: 8000, width: 70, height: 45, depth: 10, sku: 'TV32-SAMSU-XPTO90000', supplier: supplier)
    soundbar = ProductModel.create!(name: 'SoundBar 7.1 Surround', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZZ770', supplier: supplier)

    login_as(user)
    visit root_path
    within('.nav') do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPTO90000'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'SoundBar 7.1 Surround'
    expect(page).to have_content 'Samsung'
  end

  it 'e não existem produtos cadastrados' do
    user = User.create!(name: 'Marga', email: 'marga@gmail.com', password: 'password')
    
    login_as(user)
    visit root_path
    within('.nav') do
      click_on 'Modelos de Produtos'
    end

    expect(page).to have_content 'Nenhum modelo de produto cadastrado'
  end
end
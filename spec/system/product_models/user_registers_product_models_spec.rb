require 'rails_helper'

describe 'Usuário cadastra modelo de produto' do
  it 'a partir da página de modelos de produtos' do

    visit root_path
    within('.nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'Cadastrar Novo Modelo'

    expect(current_path).to eq new_product_model_path
    expect(page).to have_content 'Nome'
    expect(page).to have_content 'Peso'
    expect(page).to have_content 'Largura'
    expect(page).to have_content 'Profundidade'
    expect(page).to have_content 'Altura'
    expect(page).to have_content 'SKU'
    expect(page).to have_content 'Fornecedor'
  end

  it 'com sucesso' do
    samsung = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung LTDA', registration_number: 1234567890123, full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'emaildasamsung@gmail.com')
    apple = Supplier.create!(brand_name: 'Apple', corporate_name: 'Apple LTDA', registration_number: 4567890123456, full_address: 'Av. das Nações Unidas, 2000', city: 'São Paulo', state: 'SP', email: 'emaildaapple@gmail.com')

    visit root_path
    within('.nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'Cadastrar Novo Modelo'
    fill_in 'Nome', with: 'TV 32'
    fill_in 'Peso', with: '8000'
    fill_in 'Largura', with: '70'
    fill_in 'Altura', with: '45'
    fill_in 'Profundidade', with: '10'
    fill_in 'SKU', with: 'TV32-SAMSU-XPTO90000'
    select 'Samsung', from: 'Fornecedor'
    click_on 'Enviar'

    expect(current_path).to eq product_models_path
    expect(page).to have_content 'Modelo cadastrado com sucesso!'
    expect(page).to have_content 'TV 32'
    expect(page).to have_content 'TV32-SAMSU-XPTO90000'
    expect(page).to have_content 'Samsung'
  end

  it 'com dados incompletos' do
    samsung = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung LTDA', registration_number: 1234567890123, full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'emaildasamsung@gmail.com')
    electrolux = Supplier.create!(brand_name: 'Electrolux', corporate_name: 'Electrolux LTDA', registration_number: 9234567890123, full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'emaildasamsung@gmail.com')

    visit root_path
    within('.nav') do
      click_on 'Modelos de Produtos'
    end
    click_on 'Cadastrar Novo Modelo'
    fill_in 'Nome', with: ''
    fill_in 'Peso', with: '8000'
    fill_in 'Largura', with: ''
    fill_in 'Altura', with: '45'
    fill_in 'Profundidade', with: '10'
    fill_in 'SKU', with: 'TV32-SAMSU-XPTO90000'
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível cadastrar novo modelo'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Largura não pode ficar em branco'
  end
end
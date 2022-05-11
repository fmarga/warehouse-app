require 'rails_helper'

describe 'Usuário vê página de fornecedores' do
  it 'a partir do menu' do
    #arrange
    #act
    visit root_path
    within('.nav') do
      click_on 'Fornecedores'
    end
    #assert
    expect(current_path).to eq suppliers_path
  end 

  it 'com sucesso' do
    Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Empresa', registration_number: '1234567891234', full_address: 'Av. da Empresa, 5000', city: 'São Paulo', state: 'SP', email: 'umaempresa@gmail.com')

    visit root_path
    within('.nav') do
      click_on 'Fornecedores'
    end

    expect(page).to have_content 'Fornecedores'
    expect(page).to have_content 'Uma Empresa'
    expect(page).to have_content 'São Paulo - SP'
  end

  it 'e não existem fornecedores cadastrados' do

    visit root_path
    within('.nav') do
      click_on 'Fornecedores'
    end

    expect(page).to have_content 'Não existem fornecedores cadastrados'
  end

  it 'e volta para a página inicial' do
    visit root_path
    within('.nav') do
      click_on 'Fornecedores'
    end
    click_on 'Página Inicial'

    expect(current_path).to eq root_path
  end
end
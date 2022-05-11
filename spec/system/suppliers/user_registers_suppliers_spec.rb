require 'rails_helper'

describe 'Usuário cadastra um fornecedor' do
  it 'a partir da tela de fornecedores' do

    visit root_path
    within('.nav') do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar Fornecedor'

    expect(page).to have_content('Novo Fornecedor')
    expect(page).to have_field('Nome Fantasia')
    expect(page).to have_field('Razão Social')
    expect(page).to have_field('CNPJ')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('E-mail')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Estado')
    expect(page).to have_button('Cadastrar')
  end

  it 'com sucesso' do

    visit root_path
    within('.nav') do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social', with: 'Empresa LTDA'
    fill_in 'Nome Fantasia', with: 'Uma Empresa'
    fill_in 'CNPJ', with: '1234567891234'
    fill_in 'Endereço', with: 'Av. da Empresa, 5000'
    fill_in 'Cidade', with: 'São Paulo'
    fill_in 'Estado', with: 'SP'
    fill_in 'E-mail', with: 'umaempresa@gmail.com'
    click_on 'Cadastrar'

    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedor cadastrado com sucesso!'
    expect(page).to have_content 'Uma Empresa'
    expect(page).to have_content 'Cidade: São Paulo - SP'
  end

  it 'com dados incompletos' do

    visit root_path
    within('.nav') do
      click_on 'Fornecedores'
    end
    click_on 'Cadastrar Fornecedor'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Cidade', with: 'Porto Alegre'
    fill_in 'Estado', with: 'RS'
    click_on 'Cadastrar'

    expect(page).to have_content 'Fornecedor não cadastrado'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
  end
end
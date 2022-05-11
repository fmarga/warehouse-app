require 'rails_helper'

describe 'Usuário edita um fornecedor' do
  it 'a partir da página de detalhes' do
    supplier = Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Empresa', registration_number: 1234567890123, full_address: 'Av. da Empresa, 90', city: 'Porto Alegre', state: 'RS', email: 'emaildaempresa@gmail.com')

    visit root_path
    within('.nav') do
      click_on 'Fornecedores'
    end
    click_on 'Uma Empresa'
    click_on 'Editar'

    expect(page).to have_content 'Editar Fornecedor'
    expect(page).to have_field 'Razão Social', with: 'Empresa LTDA'
    expect(page).to have_field 'Nome Fantasia', with: 'Uma Empresa'
    expect(page).to have_field 'CNPJ', with: '1234567890123'
    expect(page).to have_field 'Endereço', with: 'Av. da Empresa, 90'
    expect(page).to have_field 'Cidade', with: 'Porto Alegre'
    expect(page).to have_field 'Estado', with: 'RS'
    expect(page).to have_field 'E-mail', with: 'emaildaempresa@gmail.com'
  end

  it 'com sucesso' do
    supplier = Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Empresa', registration_number: 1234567890123, full_address: 'Av. da Empresa, 90', city: 'Porto Alegre', state: 'RS', email: 'emaildaempresa@gmail.com')

    visit root_path
    within('.nav') do
    click_on 'Fornecedores'
    end
    click_on 'Uma Empresa'
    click_on 'Editar'
    fill_in 'Razão Social', with: 'Qualquer Empresa LTDA'
    fill_in 'Nome Fantasia', with: 'Qualquer Outra Empresa'
    fill_in 'Endereço', with: 'Av. da Outra Empresa, 9000'
    click_on 'Enviar'

    expect(page).to have_content 'Fornecedor atualizado com sucesso!'
    expect(page).to have_content 'Fornecedor Qualquer Outra Empresa'
    expect(page).to have_content 'Nome da Empresa: Qualquer Outra Empresa'
    expect(page).to have_content 'Razão Social: Qualquer Empresa LTDA'
    expect(page).to have_content 'Av. da Outra Empresa, 9000'
  end

  it 'e mantém os campos obrigatórios' do
    supplier = Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Empresa', registration_number: 1234567890123, full_address: 'Av. da Empresa, 90', city: 'Porto Alegre', state: 'RS', email: 'emaildaempresa@gmail.com')

    visit root_path
    within('.nav') do
    click_on 'Fornecedores'
    end
    click_on 'Uma Empresa'
    click_on 'Editar'
    fill_in 'Razão Social', with: ''
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Endereço', with: 'Av. da Outra Empresa, 9000'
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar os dados do fornecedor'
  end
end
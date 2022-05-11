require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do
  it 'e vê informações adicionais' do
    supplier = Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Empresa', registration_number: 1234567890123, full_address: 'Av. da Empresa, 10', city: 'Porto Alegre', state: 'RS', email: 'emaildaempresa@gmail.com')

    visit root_path
    within('.nav') do
      click_on 'Fornecedores'
    end
    click_on 'Uma Empresa'

    expect(page).to have_content 'Fornecedor Uma Empresa'
    expect(page).to have_content 'Nome da Empresa: Uma Empresa'
    expect(page).to have_content 'CNPJ: 1234567890123'
    expect(page).to have_content 'Cidade: Porto Alegre - RS'
  end

  it 'e volta para a página de fornecedores' do
    supplier = Supplier.create!(corporate_name: 'Empresa LTDA', brand_name: 'Uma Empresa', registration_number: 1234567890123, full_address: 'Av. da Empresa, 10', city: 'Porto Alegre', state: 'RS', email: 'emaildaempresa@gmail.com')

    visit root_path
    within('.nav') do
      click_on 'Fornecedores'
    end
    click_on 'Uma Empresa'
    click_on 'Voltar'

    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedores'
  end
end
require 'rails_helper'

describe 'Usuário edita um galpão' do
  it 'a partir da página de detalhes' do
    warehouse = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')
    
    visit root_path
    click_on 'Galpão do Rio'
    click_on 'Editar'

    expect(page).to have_content('Editar Galpão')
    expect(page).to have_field('Nome', with: 'Galpão do Rio')
    expect(page).to have_field('Código', with: 'SDU')
    expect(page).to have_field('Cidade', with: 'Rio de Janeiro')
    expect(page).to have_field('Área', with: '60000')
    expect(page).to have_field('Endereço', with: 'Av. do Porto, 1000')
    expect(page).to have_field('CEP', with: '20000-000')
    expect(page).to have_field('Descrição', with: 'Galpão da zona portuária do Rio de Janeiro')
  end

  it 'com sucesso' do
    warehouse = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')
    
    visit root_path
    click_on 'Galpão do Rio'
    click_on 'Editar'
    fill_in 'Nome', with: 'Galpão do Galeão'
    fill_in 'Código', with: 'GIG'
    fill_in 'Área', with: '50000'
    fill_in 'Endereço', with: 'Av. do Aeroporto, 3000'
    fill_in 'Descrição', with: 'Galpão do aeroporto internacional'
    click_on 'Enviar'

    expect(page).to have_content 'Galpão atualizado com sucesso!'
    expect(page).to have_content 'Nome: Galpão do Galeão'
    expect(page).to have_content 'GIG'
    expect(page).to have_content 'Cidade: Rio de Janeiro'
    expect(page).to have_content 'Área: 50000 m²'
  end

  it 'e mantém os campos obrigatórios' do
    warehouse = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')
    
    visit root_path
    click_on 'Galpão do Rio'
    click_on 'Editar'
    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Área', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Não foi possível atualizar o galpão'
  end
end
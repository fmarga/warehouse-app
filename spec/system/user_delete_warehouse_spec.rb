require 'rails_helper'

describe 'Usuário remove um galpão' do
  it 'com sucesso' do
    warehouse = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')

    visit root_path
    click_on 'Galpão do Rio'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Galpão do Rio' 
    expect(page).not_to have_content 'SDU'
  end

  it 'e não apaga outros galpões' do
    rio = Warehouse.create!(name: 'Galpão do Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')
    poa = Warehouse.create!(name: 'Galpão de POA', code: 'POA', city: 'Porto Alegre', area: 50_000, address: 'Av. do Aeroporto, 1000', postal_code: '90000-000', description: 'Galpão da zona portuária de Porto Alegre')

    visit root_path
    click_on 'Galpão do Rio'
    click_on 'Remover'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).to have_content 'Galpão de POA' 
    expect(page).not_to have_content 'Galpão do Rio'
  end
end
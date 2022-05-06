require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e vê o nome da app' do
    #arrange - preparação: unico bloco que pode estar vazio em um momento inicial

    #act - ação do teste
    visit(root_path) #metodo que leva o teste para a pagina requerida

    #assert - garantias
    expect(page).to have_content('Galpões & Estoque')
  end

  it 'e vê os galpões cadastrados' do
    Warehouse.create(name: 'Rio', code: 'SDU', city: 'Rio de Janeiro', area: 60_000, address: 'Av. do Porto, 1000', postal_code: '20000-000', description: 'Galpão da zona portuária do Rio de Janeiro')
    Warehouse.create(name: 'Maceio', code: 'MCZ', city: 'Maceio', area: 50_000, address: 'Av. Atlântica, 1000', postal_code: '80000-000', description: 'Galpão da zona portuária de Maceió')

    visit(root_path)

    expect(page).not_to have_content('Não existem galpões cadastrados')
    expect(page).to have_content('Rio')
    expect(page).to have_content('Código: SDU')
    expect(page).to have_content('Cidade: Rio de Janeiro')
    expect(page).to have_content('60000 m²')

    expect(page).to have_content('Maceio')
    expect(page).to have_content('Código: MCZ')
    expect(page).to have_content('Cidade: Maceio')
    expect(page).to have_content('50000 m²')
  end

  it 'e não existem galpões cadastrados' do

    visit(root_path)

    expect(page).to have_content('Não existem galpões cadastrados')
  end
end
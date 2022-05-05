require 'rails_helper'

describe 'Usuário cadastra um galpão' do
  it 'a partir da tela inicial' do
    visit root_path
    click_on 'Cadastrar Galpão'

    expect(page).to have_field('Nome')
    expect(page).to have_field('Código')
    expect(page).to have_field('Cidade')
    expect(page).to have_field('Área')
    expect(page).to have_field('Endereço')
    expect(page).to have_field('CEP')
    expect(page).to have_field('Descrição')
  end

  it 'com sucesso' do
    visit root_path
    click_on 'Cadastrar Galpão'
    fill_in 'Nome', with: 'Galpão POA'
    fill_in 'Código', with: 'POA'
    fill_in 'Cidade', with: 'Porto Alegre'
    fill_in 'Área', with: '10000'
    fill_in 'Endereço', with: 'Av. do Galpão, 1000'
    fill_in 'CEP', with: '90000-000'
    fill_in 'Descrição', with: 'Galpão da região sul localizado na cidade de Porto Alegre'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Porto Alegre'
    expect(page).to have_content 'POA'
    expect(page).to have_content '10000 m²'
  end
end
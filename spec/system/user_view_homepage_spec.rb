require 'rails_helper'

describe 'Usuario visita tela inicial' do
  it 'e vê o nome da app' do
    #arrange - unico bloco que pode estar vazio em um momento inicial

    #act
    visit('/') #metodo que leva o teste para a pagina requerida

    #assert
    expect(page).to have_content('Galpões & Estoque')
  end
end
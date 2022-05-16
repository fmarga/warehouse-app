require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do
    User.create!(email: 'marga@gmail.com', password: 'password')

    visit root_path
    within('.nav') do
      click_on 'Entrar'
    end
    within('form') do
      fill_in "E-mail",	with: "marga@gmail.com" 
      fill_in "Senha",	with: "password"
      click_on 'Entrar'
    end

    expect(page).to have_content 'Login efetuado com sucesso'
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar'
    expect(page).not_to have_link 'Entrar'
    within('.nav') do
      expect(page).to have_content 'marga@gmail.com'
    end
  end
end
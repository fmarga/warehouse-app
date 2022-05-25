require 'rails_helper'

describe 'Usuário se autentica' do
  it 'com sucesso' do

    visit root_path
    click_on 'Entrar'
    click_on 'Criar uma Conta'
    fill_in 'Nome', with: 'Marga'
    fill_in 'E-mail', with: 'marga@gmail.com'
    fill_in 'Senha', with: 'password'
    fill_in 'Confirme sua senha', with: 'password'
    click_on 'Criar Conta'

    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
    user = User.last
    expect(user.name).to eq 'Marga'
    expect(page).to have_content 'Olá Marga'
    expect(page).to have_button 'Sair'
  end
end
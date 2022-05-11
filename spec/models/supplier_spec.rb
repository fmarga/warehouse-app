require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when the corporate name is empty' do
        supplier = Supplier.create(corporate_name: '', brand_name: 'Uma empresa', registration_number: '1234567890123', full_address: 'Av da Empresa, 10', city: 'Porto Alegre', state: 'RS', email: 'emailqualquer@gmail.com')

        expect(supplier.valid?).to eq false
      end

      it 'false when brand name is empty' do
        supplier = Supplier.create(corporate_name: 'Empresa LTDA', brand_name: '', registration_number: '1234567890123', full_address: 'Av da Empresa, 10', city: 'Porto Alegre', state: 'RS', email: 'emailqualquer@gmail.com')

        expect(supplier.valid?).to eq false
      end

      it 'false when registration number is empty' do
        supplier = Supplier.create(corporate_name: 'Empresa LTDA', brand_name: 'Uma empresa', registration_number: '', full_address: 'Av da Empresa, 10', city: 'Porto Alegre', state: 'RS', email: 'emailqualquer@gmail.com')

        expect(supplier.valid?).to eq false
      end

      it 'false when email is empty' do
        supplier = Supplier.create(corporate_name: 'Empresa LTDA', brand_name: 'Uma empresa', registration_number: '1234567890123', full_address: 'Av da Empresa, 10', city: 'Porto Alegre', state: 'RS', email: '')

        expect(supplier.valid?).to eq false
      end
    end

    context 'uniqueness' do
      it 'false when registration number is already in use' do
        first_supplier = Supplier.create(corporate_name: 'Empresa LTDA', brand_name: 'Uma empresa', registration_number: '1234567890123', full_address: 'Av da Empresa, 10', city: 'Porto Alegre', state: 'RS', email: 'email@email.com')
        second_supplier = Supplier.create(corporate_name: 'Outra Empresa LTDA', brand_name: 'Uma empresa qualquer', registration_number: '1234567890123', full_address: 'Av da Empresa, 11', city: 'Porto Alegre', state: 'RS', email: 'email@email.com')

        expect(second_supplier.valid?).to eq false
      end
    end

    context 'length' do
      it 'false when registration number is bigger than 13 characters' do
        supplier = Supplier.create(corporate_name: 'Outra Empresa LTDA', brand_name: 'Uma empresa qualquer', registration_number: '12345678901230', full_address: 'Av da Empresa, 11', city: 'Porto Alegre', state: 'RS', email: 'email@email.com')

        expect(supplier.valid?).to eq false
      end

      it 'false when registration number is smaller than 13 characters' do
        supplier = Supplier.create(corporate_name: 'Outra Empresa LTDA', brand_name: 'Uma empresa qualquer', registration_number: '123456789012', full_address: 'Av da Empresa, 11', city: 'Porto Alegre', state: 'RS', email: 'email@email.com')

        expect(supplier.valid?).to eq false
      end
    end
  end
end

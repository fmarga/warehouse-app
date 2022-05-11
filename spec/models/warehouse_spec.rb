require 'rails_helper'

RSpec.describe Warehouse, type: :model do
  describe '#valid?' do
    context 'presence' do
      it 'false when name is empty' do
        #arrange
        warehouse = Warehouse.new(name: '', code: 'POA', city: 'Porto Alegre', area: 20000, address: 'Av. do Galpão, 10', postal_code: '90000-000', description: 'Galpão da cidade de Porto Alegre')
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq false
      end

      it 'false when code is empty' do
        #arrange
        warehouse = Warehouse.new(name: 'POA', code: '', city: 'Porto Alegre', area: 20000, address: 'Av. do Galpão, 10', postal_code: '90000-000', description: 'Galpão da cidade de Porto Alegre')
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq false
      end

      it 'false when city is empty' do
        #arrange
        warehouse = Warehouse.new(name: 'POA', code: 'POA', city: '', area: 20000, address: 'Av. do Galpão, 10', postal_code: '90000-000', description: 'Galpão da cidade de Porto Alegre')
        #act
        result = warehouse.valid?
        #assert
        expect(result).to eq false
      end

      it 'false when area is empty' do 
        warehouse = Warehouse.new(name: 'POA', code: 'POA', city: 'Porto Alegre', area: '', address: 'Av. do Galpão, 10', postal_code: '90000-000', description: 'Galpão da cidade de Porto Alegre')

        result = warehouse.valid?

        expect(result).to eq false
      end

      it 'false when address is empty' do
        warehouse = Warehouse.new(name: 'POA', code: 'POA', city: 'Porto Alegre', area: 20000, address: '', postal_code: '90000-000', description: 'Galpão da cidade de Porto Alegre')

        expect(warehouse.valid?).to eq false
      end

      it 'false when postal_code is empty' do
        warehouse = Warehouse.new(name: 'POA', code: 'POA', city: 'Porto Alegre', area: 20000, address: 'Av. do Galpão, 10', postal_code: '', description: 'Galpão da cidade de Porto Alegre')

        expect(warehouse.valid?).to eq false
      end

      it 'false when description is empty' do
        warehouse = Warehouse.new(name: 'POA', code: 'POA', city: 'Porto Alegre', area: 20000, address: 'Av. do Galpão, 10', postal_code: '90000-000', description: '')
        
        expect(warehouse.valid?).to eq false
      end
    end

    context '#uniqueness' do
      it 'false when code is already in use' do
        #arrange - criar 2 galpoes com o mesmo código
        first_warehouse = Warehouse.create(name: 'POA', code: 'POA', city: 'Porto Alegre', area: 20000, address: 'Av. do Galpão, 10', postal_code: '90000-000', description: 'Galpão da cidade de Porto Alegre')
        second_warehouse = Warehouse.new(name: 'OPA', code: 'POA', city: 'Alegre Porto', area: 30000, address: 'Av. do Outro Galpão, 1000', postal_code: '90000-001', description: 'Outro galpão da cidade de Porto Alegre')
        #act
        result = second_warehouse.valid?
        #assert
        expect(result).to eq false
      end

      it 'false when name is already in use' do
        first_warehouse = Warehouse.create(name: 'Galpão Porto Alegre', code: 'POA', city: 'Porto Alegre', area: 20000, address: 'Av. do Galpão, 10', postal_code: '90000-000', description: 'Galpão da cidade de Porto Alegre')
        second_warehouse = Warehouse.new(name: 'Galpão Porto Alegre', code: 'OPA', city: 'Alegre Porto', area: 30000, address: 'Av. do Outro Galpão, 1000', postal_code: '90000-001', description: 'Outro galpão da cidade de Porto Alegre')

        expect(second_warehouse.valid?).to eq false
      end
    end

    context '#format' do
      it 'false when postal code is incomplete' do
        warehouse = Warehouse.create(name: 'Galpão Porto Alegre', code: 'POA', city: 'Porto Alegre', area: 20000, address: 'Av. do Galpão, 10', postal_code: '90000-00', description: 'Galpão da cidade de Porto Alegre')
        
        expect(warehouse.valid?).to be_falsy
      end
    end

    context '#length' do
      it 'false when code is bigger than 3 characters' do
        warehouse = Warehouse.create(name: 'Galpão Porto Alegre', code: 'POAS', city: 'Porto Alegre', area: 20000, address: 'Av. do Galpão, 10', postal_code: '90000-000', description: 'Galpão da cidade de Porto Alegre')
        
        expect(warehouse.valid?).to be_falsy
      end
    end
  end
end

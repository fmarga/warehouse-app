require 'rails_helper'

RSpec.describe Order, type: :model do

  describe '#valid?' do
    it 'deve ter um código' do
      user = User.create!(name: 'Maria', email: 'maria@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'POA', code: 'POA', city: 'Porto Alegre', area: 20000, address: 'Av. do Galpão, 10', postal_code: '90000-000', description: 'Galpão da cidade de Porto Alegre')
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung LTDA', registration_number: 1234567890123, full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'emaildasamsung@gmail.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')

      result = order.valid?

      expect(result).to be true
    end

    it 'data estimada de entrega deve ser obrigatória' do
      order = Order.new(estimated_delivery_date: '')

      order.valid?
      result = order.errors.include?(:estimated_delivery_date)

      expect(result).to be true
    end

    it 'data estimada de entrega não deve ser anterior ao dia do pedido' do
      order = Order.new(estimated_delivery_date: 1.day.ago)

      order.valid?

      expect(order.errors.include?(:estimated_delivery_date)).to be true
      expect(order.errors[:estimated_delivery_date]).to include(' deve ser futura')
    end
  end

  describe 'gera um código aleatório' do
    it 'ao criar um novo pedido' do
      user = User.create!(name: 'Maria', email: 'maria@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'POA', code: 'POA', city: 'Porto Alegre', area: 20000, address: 'Av. do Galpão, 10', postal_code: '90000-000', description: 'Galpão da cidade de Porto Alegre')
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung LTDA', registration_number: 1234567890123, full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'emaildasamsung@gmail.com')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')

      order.save
      result = order.code

      expect(result).not_to be_empty
      expect(result.length).to eq 8
    end

    it 'e o código é único' do
      user = User.create!(name: 'Maria', email: 'maria@email.com', password: 'password')
      warehouse = Warehouse.create!(name: 'POA', code: 'POA', city: 'Porto Alegre', area: 20000, address: 'Av. do Galpão, 10', postal_code: '90000-000', description: 'Galpão da cidade de Porto Alegre')
      supplier = Supplier.create!(brand_name: 'Samsung', corporate_name: 'Samsung LTDA', registration_number: 1234567890123, full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'emaildasamsung@gmail.com')
      first_order = Order.create!(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-10-01')
      order = Order.new(user: user, warehouse: warehouse, supplier: supplier, estimated_delivery_date: '2022-11-15')

      order.save
      result = order.code

      expect(order.code).not_to eq first_order.code
    end
  end
end

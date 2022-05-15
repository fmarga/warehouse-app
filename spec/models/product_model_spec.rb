require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do
    it 'name is mandatory' do
      supplier = Supplier.create(brand_name: 'Samsung', corporate_name: 'Samsung LTDA', registration_number: 1234567890123, full_address: 'Av. das Nações Unidas, 1000', city: 'São Paulo', state: 'SP', email: 'emaildasamsung@gmail.com')
      pm = ProductModel.create(name: '', weight: 3000, width: 80, height: 15, depth: 20, sku: 'SOU71-SAMSU-NOIZZ770', supplier: supplier)

      expect(pm.valid?).to eq false
    end
  end
end

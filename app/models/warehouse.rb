class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :postal_code, :description, presence: true
end

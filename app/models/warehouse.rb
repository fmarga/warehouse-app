class Warehouse < ApplicationRecord
  validates :name, :code, :city, :area, :address, :postal_code, :description, presence: true
  validates :name, :code, uniqueness: true
  validates :postal_code, format: { with: /\d{5}-?\d{3}/ }
  validates :code, length: { is: 3 }

  def full_description
    "#{code} | #{name}"
  end
end

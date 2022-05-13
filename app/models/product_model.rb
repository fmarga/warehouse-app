class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :sku, length: { is: 20 }
  validates :name, :weight, :height, :width, :depth, :sku, :supplier, presence: true
  validates :sku, uniqueness: true
  validates :weight, :height, :width, :depth, numericality: { :greater_than: 0 }
end

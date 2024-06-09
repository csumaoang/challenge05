class Product < ApplicationRecord
    belongs_to :category
    validates :title, :price, :stock_quantity, presence: true
  end
  
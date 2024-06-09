class Product < ApplicationRecord
    validates :title, :price, :stock_quantity, presence: true
end

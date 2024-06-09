# db/seeds.rb

require 'csv'

# Clear out existing data
Product.destroy_all
Category.destroy_all

# Read the CSV file
csv_file = Rails.root.join('db/products.csv')
csv_data = File.read(csv_file)

# Parse the CSV data
products = CSV.parse(csv_data, headers: true)

puts "Loaded #{products.size} products from CSV"

products.each do |product|
  # Check for missing required fields
  if product['title'].blank? || product['stock_quantity'].blank?
    puts "Skipping product due to missing required fields: #{product.inspect}"
    next
  end

  # Find or create the category
  category_name = product['category']
  category = Category.find_or_create_by(name: category_name)

  # Create the product
  begin
    Product.create!(
      title: product['title'],
      description: product['description'],
      price: product['price'],
      stock_quantity: product['stock_quantity'],
      category: category
    )
    puts "Created product: #{product['title']}"
  rescue ActiveRecord::RecordInvalid => e
    puts "Failed to create product: #{e.record.errors.full_messages.join(', ')}"
  end
end

puts "Created #{Category.count} categories"
puts "Created #{Product.count} products"

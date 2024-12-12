require 'faker'

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data

puts "Deleting current users"
User.delete_all

puts "Creating users..."
40.times do
  generated_phone = "+1#{Faker::Number.number(digits: 10)}"
  User.create!(
    username: Faker::Internet.unique.username(specifier: 5..8, separators: [ "_" ]),
    password: Faker::Internet.password(min_length: 8, max_length: 16),
    email: Faker::Internet.unique.email,
    phone: generated_phone,
    bio: Faker::Lorem.paragraph,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    role: Faker::Number.between(from: 0, to: 2),
    status: Faker::Number.between(from: 0, to: 1),
    joined_at: Faker::Date.backward(days: 365 * 5)
  )
end

puts "Creating demo users..."
User.create!(
  username: "admin",
  password: "admin-password",
  email: "admin@email.com",
  phone:  "+1#{Faker::Number.number(digits: 10)}",
  bio: Faker::Lorem.paragraph,
  first_name: "Administrator",
  last_name: "Avivas",
  role: 3,
  status: 0,
  joined_at: Faker::Date.backward(days: 365 * 5)
)
User.create!(
  username: "manager",
  password: "manager-password",
  email: "manager@email.com",
  phone:  "+1#{Faker::Number.number(digits: 10)}",
  bio: Faker::Lorem.paragraph,
  first_name: "Manager",
  last_name: "Avivas",
  role: 2,
  status: 0,
  joined_at: Faker::Date.backward(days: 365 * 5)
)
User.create!(
  username: "employee",
  password: "employee-password",
  email: "employee@email.com",
  phone:  "+1#{Faker::Number.number(digits: 10)}",
  bio: Faker::Lorem.paragraph,
  first_name: "Employee",
  last_name: "Avivas",
  role: 1,
  status: 0,
  joined_at: Faker::Date.backward(days: 365 * 5)
)

puts "Deleting current products..."

puts "Seeding products..."
Product.delete_all

40.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    base_price: Faker::Commerce.price(range: 10.0..100.0).round(2),
    stock_quantity: Faker::Number.between(from: 1, to: 100),
    published: [true, false].sample,
    deleted: false,
    deleted_at: nil
  )
end

puts "Deleting current categories"
Product::Category.delete_all

puts "Seeding categories..."

10.times do
  Product::Category.create!(
    name: Faker::Commerce.department(),
    description: Faker::Marketing.buzzwords.capitalize + " styles for every occasion.",
    active: true
  )
end

puts "Seeding complete! ✔"
puts "Cleaning up..."
puts "Created #{User.count} users"
puts "Created #{Product.count} products"
puts "Created #{Product::Category.count} product categories"

puts "Done!"

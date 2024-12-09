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

# Seed with new data
40.times do
  generated_phone = "+1#{Faker::Number.number(digits: 10)}"
  User.create!(
    username: Faker::Internet.unique.username(specifier: 5..8, separators: [ "_" ]),
    password: Faker::Internet.password(min_length: 8, max_length: 16),
    email: Faker::Internet.unique.email,
    phone: generated_phone,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    role: Faker::Number.between(from: 0, to: 2),
    status: Faker::Number.between(from: 0, to: 1),
    joined_at: Faker::Date.backward(days: 365 * 5)
  )
end

User.create!(
  username: "admin",
  password: "admin-password",
  email: "admin@email.com",
  phone:  "+1#{Faker::Number.number(digits: 10)}",
  first_name: "Avivas",
  last_name: "Administrator",
  role: 2,
  status: 0,
  joined_at: Faker::Date.backward(days: 365 * 5)
)

puts "Created #{User.count} users"

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# User.find_or_create_by!(email: 'admin@example.com') do |user|
#   user.password = 'password'
#   user.admin = true
#   # Add other attributes here
# end
require 'faker'

# Create a admin user
# admin_email = "jsequeirag@ucenfotec.ac.cr"
# admin_password = "Cenfotec123!"

# admin = User.find_or_initialize_by(email: admin_email)
# admin.password = admin_password
# admin.password_confirmation = admin_password
# admin.role = 2 # Assuming '2' is the role for admin
# admin.first_name = 'Super'
# admin.last_name = 'Admin'
# admin.phone = '88556699'
# admin.id_number = '111113333'
# admin.save!

# puts "Admin user created succesfully! \n" +
#      "\n Admin user details: \n"
# puts "Name: #{admin.first_name}" + " " + "#{admin.last_name}"
# puts "Email: #{admin.email}" + ", " + "Phone: #{admin.phone}"
# puts "Password: #{admin.password}"
# puts "ID Number: #{admin.id_number}"
# puts "Role: #{admin.role}"

# Create a hotel using Faker
# image_files = Dir[Rails.root.join('app', 'assets', 'images', 'hotels', '*')]

# 10.times do
#   hotel = Hotel.create!(
#     name: Faker::Company.name,
#     phone: Faker::PhoneNumber.cell_phone_in_e164,
#     email: Faker::Internet.email,
#     description: Faker::Lorem.paragraph,
#     rating: 0,
#     rooms_ids: [],
#     user_id: 3,

#     # Nested attributes for the address
#     address_attributes: {
#       country: Faker::Address.country,
#       city: Faker::Address.city,
#       place_name: Faker::Address.street_name
#     }
#   )

#   # Add 1, 2 or 3 images to each hotel randomly
#   random_images = image_files.sample(rand(1..3))

#   random_images.each do |image|
#     hotel.images.attach(
#       io: File.open(image),
#       filename: File.basename(image),
#       content_type: "image/jpeg"
#     )
#   end

#   puts "Hotel and Address created successfully!"
#   puts "Name: #{hotel.name}"
#   puts "Address: #{hotel.address.compound_address}"
#   puts "Phone: #{hotel.phone}"
#   puts "Email: #{hotel.email}"
#   puts "Description: #{hotel.description}"
# end

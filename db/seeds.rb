require 'faker'

# ADMIN USER
# Create a admin user
# admin_email = ENV['ADMINEMAIL']
# admin_password = ENV['ADMINPASSWORD']
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

# CLIENT USERS
# 20.times do
# client_email = Faker::Internet.email
# client_password = ENV['ADMINPASSWORD']

# client = User.find_or_initialize_by(email: client_email)
# client.password = client_password
# client.password_confirmation = client_password
# client.role = 1
# client.first_name = Faker::Name.first_name
# client.last_name = Faker::Name.last_name
# client.phone = Faker::PhoneNumber.cell_phone_in_e164
# client.id_number = Faker::IdNumber.valid
# client.save!
# puts "Client user created succesfully! \n" +
#      "\n Admin user details: \n"
# puts "Name: #{client.full_name}"
# puts "Email: #{client.email}" + ", " + "Phone: #{client.phone}"
# puts "Password: #{client.password}"
# puts "ID Number: #{client.id_number}"
# puts "Role: #{client.role}"
# end

# HOTELS
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

# ROOMS
# Create rooms and add them to existing hotels
50.times do
  hotel = Hotel.order("RANDOM()").first

  room_type = ["economic", "premium", "luxury"].sample
  number_of_rooms = hotel.rooms.where(room_type: room_type).maximum(:number_of_rooms).to_i + 1

  price_range = case room_type
          when "economic"
          50.0..200.0
          when "premium"
          200.0..500.0
          when "luxury"
          500.0..1000.0
          else
          50.0..1000.0
          end

  room = Room.new(
    room_type: room_type,
    status: "available",
    hotel_id: hotel.id,
    capacity: rand(2..12),
    beds: rand(1..6),
    price_per_night: Faker::Commerce.price(range: price_range),
    number_of_rooms: number_of_rooms
  )

  puts "Attempting to create room with attributes: #{room.attributes}"

  if room.save
    puts "Room created successfully!"
    puts "Type: #{room.room_type}"
    puts "Code: #{room.code}"
    puts "Room Number: #{room.number_of_rooms}"
    puts "Status: #{room.status}"
    puts "Hotel: #{hotel.name}"
    puts "Beds: #{room.beds}"
    puts "Capacity: #{room.capacity}"
    puts "Price per Night: #{room.price_per_night}"
  else
    puts "Failed to create room: #{room.errors.full_messages.join(", ")}"
    room.errors.each do |attribute, message|
      puts "Validation error on #{attribute}: #{message}"
    end
  end
end
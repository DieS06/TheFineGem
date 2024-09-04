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

admin_email = "jsequeirag@ucenfotec.ac.cr"
admin_password = "Cenfotec123!"

admin = User.find_or_initialize_by(email: admin_email)
admin.password = admin_password
admin.password_confirmation = admin_password
admin.role = 2 # Assuming '2' is the role for admin
admin.first_name = 'Super'
admin.last_name = 'Admin'
admin.phone = '88556699'
admin.id_number = '111113333'
admin.save!

# puts "Admin user created succesfully! \n" +
#      "\n Admin user details: \n"
# puts "Name: #{admin.first_name}" + " " + "#{admin.last_name}"
# puts "Email: #{admin.email}" + ", " + "Phone: #{admin.phone}"
# puts "Password: #{admin.password}"
# puts "ID Number: #{admin.id_number}"
# puts "Role: #{admin.role}"

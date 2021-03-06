# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
  AdminRole.destroy_all

  %w(admin moderator).each do |name|
    AdminRole.create(name: name)
  end

  puts "admin role: (#{ AdminRole.count })"
end

ActiveRecord::Base.transaction do
  AdminUser.destroy_all

  AdminUser.create(email: ENV['GMAIL_USERNAME'], password: ENV['GMAIL_PASSWORD'], password_confirmation: ENV['GMAIL_PASSWORD'], admin_roles: [AdminRole.find_by_name('admin')])

  puts "admin user: (#{ AdminUser.count })"
end
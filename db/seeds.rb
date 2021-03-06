# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
# Environment variables (ENV['...']) can be set in the file config/application.yml.
# See http://railsapps.github.io/rails-environment-variables.html
puts 'ROLES'
YAML.load(ENV['ROLES']).each do |role|
  Role.find_or_create_by_name(role)
  puts 'role: ' << role
end
puts 'DEFAULT USERS'
user = User.find_or_create_by_email :name => ENV['ADMIN_NAME'].dup, :email => ENV['ADMIN_EMAIL'].dup, :password => ENV['ADMIN_PASSWORD'].dup, :password_confirmation => ENV['ADMIN_PASSWORD'].dup
puts 'user: ' << user.name
user.add_role :admin

senders = [
  {
    name: 'Gmail',
    address: 'smtp.gmail.com',
    port: 587,
    domain: 'gmail.com',
    authentication: 'plain',
    enable_starttls_auto: true,
    limit: 500,
    full_user_name: true
  },
  {
    name: "Yahoo",
    address: 'smtp.mail.yahoo.com',
    port: 587,
    domain: 'yahoo.com',
    authentication: 'plain',
    enable_starttls_auto: true,
    limit: 500,
    full_user_name: false
  },
  {
    name: "Yahoo Chile",
    address: 'smtp.mail.yahoo.com',
    port: 587,
    domain: 'yahoo.cl',
    authentication: 'plain',
    enable_starttls_auto: true,
    limit: 500,
    full_user_name: false
  },
  {
    name: "Outlook",
    address: 'smtp.live.com',
    port: 587,
    domain: 'live.com',
    authentication: 'plain',
    enable_starttls_auto: true,
    limit: 450,
    full_user_name: true
  },
  {
    name: "Yandex",
    address: 'smtp.yandex.com',
    port: 25,
    domain: 'yandex.ru.com',
    authentication: 'plain',
    enable_starttls_auto: false,
    limit: 450,
    full_user_name: true
  }
]

senders.each do |sender|
  sender_entity = SenderEntity.where(name: sender[:name]).first_or_create
  sender_entity.update_attributes sender
end

PageType.where(name: 'Facebook Account').first_or_create
PageType.where(name: 'Twitter Account').first_or_create
PageType.where(name: 'LinkedIn Account').first_or_create
PageType.where(name: 'Contact Page').first_or_create
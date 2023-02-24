require 'faker'
require 'open-uri'
require 'nokogiri'

puts 'Cleaning the DB..'
Booking.destroy_all
Experience.destroy_all
User.destroy_all

puts 'Creating  users...'
users = []
10.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "12345678"
  )
  url = 'https://this-person-does-not-exist.com/en'
  doc = Nokogiri::HTML(URI.open(url).read)
  src = doc.search('#avatar').first['src']
  photo_url = "https://this-person-does-not-exist.com#{src}"
  file = URI.open(photo_url)
  user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
  users << user
end

puts 'Creating  experiences...'
user = users.sample
Experience.create!(
  title: "Lose yourself at Kilimanjaro and forget your worries",
  location: "Tanzania",
  description: "Be one with nature and indulge in the beauty of the wilderness",
  price: Faker::Number.number(digits: 4),
  category: "Mountain",
  user: user
)
Experience.create!(
  title: "Find your inner self in the Himalayas",
  location: "Nepal",
  description: "Tha majestic beauty of the Himalayas will leave you speechless",
  price: Faker::Number.number(digits: 4),
  category: "Mountain",
  user: user
)
Experience.create!(
  title: "Explore the beauty of the Amazon",
  location: "Brazil",
  description: "The Amazon is the largest rainforest in the world and is home to a variety of exotic animals",
  price: Faker::Number.number(digits: 4),
  category: "Rainforest",
  user: user
)
Experience.create!(
  title: "Witness the beauty of the Indonesian archipelago",
  location: "Indonesia",
  description: "The Indonesian archipelago is home to a variety of exotic animals and is a great place to explore",
  price: Faker::Number.number(digits: 4),
  category: "Island",
  user: user
)
Experience.create!(
  title: "Suffer in the heat of the Sahara",
  location: "Morocco",
  description: "The Sahara is the largest desert in the world and its harsh climate will break your will",
  price: Faker::Number.number(digits: 4),
  category: "Desert",
  user: user
)
Experience.create!(
  title: "Wander through the streets of Paris penniless",
  location: "France",
  description: "The city of love will become your city of sorrow",
  price: Faker::Number.number(digits: 4),
  category: "City",
  user: user
)

puts 'Creating  bookings...'
10.times do
  Booking.create!(
    status: ["pending", "accepted", "rejected"].sample,
    start_date: Faker::Date.between(from: '2023-02-23', to: '2023-03-01'),
    end_date: Faker::Date.between(from: '2023-03-02', to: '2023-03-25'),
    experience: Experience.all.sample,
    user: users.sample
  )
end

puts "... created #{Experience.count} experiences, #{User.count} users and
#{Booking.count} bookings."

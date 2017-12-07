# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
15.times do
  SellPost.create(
    title: Faker::RickAndMorty.location,
    body: Faker::RickAndMorty.quote,
    phone: Faker::PhoneNumber.cell_phone,
    name: Faker::RickAndMorty.character,
    sell_currency: [0,1].sample
  )
end

# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Game.create(name: 'Call of Duty', summary: 'testing', release_date: Date.today, category: 0, rating: 5.6)
Game.create(name: 'Call of Duty 2', summary: 'testing', release_date: Date.today, category: 1, rating: 5.6, parent_id: 1)
Game.create(name: 'Call of Duty 3', summary: 'testing', release_date: Date.today, category: 1, rating: 5.6, parent_id: 1)
User.create(username: 'develobet', email: 'robertmedib1@gmail.com', birth_date: '2020-01-15')
Company.create(name: 'RobertCORP', description: 'Testing Company', start_date: Time.now, country: 'Perú')
Company.first.reviews.create(title: 'New Company Review', body: 'This is the great body', user: User.first)
Company.first.reviews.create(title: 'New Company Review', body: 'This is the great body', user: User.first)
Game.first.reviews.create(title: "New Game Review", body: "This is the great body", user: User.first)
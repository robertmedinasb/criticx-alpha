# frozen_string_literal: true

require 'json'

def create_genres_relationships(new_game, genres)
  return if genres.nil?

  begin
    genres.each { |genre| new_game.genres << Genre.find_by(name: genre) }
  rescue StandardError
    p "Genre relationship not created for #{new_game}"
  end
end

def create_platforms_relationships(new_game, platforms)
  return if platforms.nil?

  begin
    platforms.each { |platform| new_game.platforms << Platform.find_by(name: platform) }
  rescue StandardError
    p "Platform relationship not created for #{new_game}"
  end
end

def create_involved_companies_relationships(new_game, involved_companies)
  return if involved_companies.nil?

  begin
    involved_companies.each do |involved_company|
      company = Company.find_by(name: involved_company['name'])
      InvolvedCompany.create(company: company,
                             game: new_game,
                             developer: involved_company['developer'],
                             publisher: involved_company['publisher'])
    end
  rescue StandardError
    p "Involved company relationship not created for #{new_game}"
  end
end

def create_game_relationships(new_game, game)
  create_genres_relationships(new_game, game['genres'])
  create_platforms_relationships(new_game, game['platforms'])
  create_involved_companies_relationships(new_game, game['involved_companies'])
end

puts 'Start seeding data'

companies = JSON.parse(File.read('db/data/companies.json'))
genres = JSON.parse(File.read('db/data/genres.json'))
platforms = JSON.parse(File.read('db/data/platforms.json'))
games = JSON.parse(File.read('db/data/games.json'))

puts 'Loading companies'
companies.each do |company|
  new_company = Company.new(company)
  p "#{new_company} not created" unless new_company.save
end

puts 'Loading platforms'
platforms.each do |platform|
  new_platform = Platform.new(platform)
  p "#{new_platform} not created" unless new_platform.save
end

puts 'Loading genres'
genres.each do |genre|
  new_genre = Genre.new(name: genre)
  p "#{new_genre} not created" unless new_genre.save
end

puts 'Loading main games and relationships'
main_games = games.select { |game| game['parent'].nil? }

main_games.each do |game|
  new_game = Game.new(game.slice('name', 'summary', 'release_data', 'category', 'rating'))
  if new_game.save
    create_game_relationships(new_game, game)
  else
    p "#{new_game} not created"
  end
end
puts 'Loading expansion games and relationships'

expansion_games = games.reject { |game| game['parent'].nil? }

expansion_games.each do |game|
  new_game = Game.new(game.slice('name', 'summary', 'release_data', 'category', 'rating'))
  if new_game.save
    create_genres_relationships(new_game, game)
  else
    p "#{new_game} not created"
  end
end

puts 'End seeding data'

# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :companies, through: :involved_companies
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :genres
  has_many :expansions, class_name: 'Game', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Game', optional: true
  enum category: { console: 0, arcade: 1, platform: 2, operating_system: 3, portable_console: 4, computer: 5 }
  validates :category, inclusion: { in: [Game.category] }
end

# frozen_string_literal: true

class Game < ApplicationRecord
  # associations

  has_many :involved_companies
  has_many :companies, through: :involved_companies
  has_and_belongs_to_many :platforms
  has_and_belongs_to_many :genres
  has_many :reviews, as: :reviewable
  has_many :expansions, class_name: 'Game', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Game', optional: true

  # enumerations
  enum category: { main_game: 0, expansion: 1 }

  # validations
  validates :name, :category, presence: true
  validates :name, uniqueness: true
  validates :rating, numericality: { greater_than_or_equal: 0, less_than_or_equal_to: 100 }
  validates :parent, inclusion: { in: Game.where(category: 'main_game') }, if: :category_is_expansion?

  private

  def category_is_expansion?
    category == 'expansion'
  end
end

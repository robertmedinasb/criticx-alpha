# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :involvedcompanies
  has_many :games, through: :group_memberships
  has_many :reviews, as: :reviewable

  # validations

  validates :name, :country, presence: true
  validates :name, uniqueness: true
end

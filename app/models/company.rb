# frozen_string_literal: true

class Company < ApplicationRecord
  has_many :involvedcompanies
  has_many :games, through: :group_memberships
  has_many :reviews, as: :reviewable
end

# frozen_string_literal: true

class InvolvedCompany < ApplicationRecord
  belongs_to :company
  belongs_to :game

  # validations
  validates :developer, :publisher, presence: true
end

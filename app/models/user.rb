# frozen_string_literal: true

class User < ApplicationRecord
  has_many :reviews
  before_create do |user|
    user.review_count = 0
  end
end

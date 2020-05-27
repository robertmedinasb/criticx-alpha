# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  after_create do |review|
    user = User.find(review.user_id)
    user.increment(:review_count)
    user.save
  end

  after_destroy do |review|
    user = User.find(review.user_id)
    user.decrement(:review_count)
    user.save
  end
end

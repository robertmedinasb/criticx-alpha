# frozen_string_literal: true

class Review < ApplicationRecord
  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  after_create do |review|
    user_id = review.user_id
    User.find(user_id).update(review_count: user.review_count + 1)
  end

  after_destroy do |review|
    user_id = review.user_id
    User.find(user_id).update(review_count: user.review_count - 1)
  end
end

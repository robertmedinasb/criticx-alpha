# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews

  # validations
  validates :username, :email, presence: true
  validate :should_be_16_years_old

  private

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def should_be_16_years_old
    unless birth_date > 16.years.ago
      'You should be 16 years old to create an account'
    end
  end
end

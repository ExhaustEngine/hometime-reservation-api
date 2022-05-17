class Guest < ApplicationRecord
  has_many :reservations
  validates :email, uniqueness: true
end

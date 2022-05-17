class Reservation < ApplicationRecord
  belongs_to :guest
  validates :source_reservation_code, uniqueness: true
end

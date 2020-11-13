class Vehicle < ApplicationRecord
  validates :manufacture, :model, presence: true
  validates :license_plate, uniqueness: true, presence: true
end

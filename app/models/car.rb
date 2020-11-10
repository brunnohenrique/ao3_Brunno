class Car < ApplicationRecord
  validates :manufacture, presence: true
  validates :model, presence: true
  validates :license_plate, uniqueness: true, presence: true
end

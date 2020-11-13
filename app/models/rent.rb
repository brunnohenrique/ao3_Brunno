class Rent < ApplicationRecord
  belongs_to :vehicle

  validates :cpf, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end

class Rent < ApplicationRecord
  belongs_to :vehicle

  validates :cpf, :start_date, :end_date, presence: true
end

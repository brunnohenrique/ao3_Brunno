class Rent < ApplicationRecord
  belongs_to :vehicle

  validates :start_date, :end_date, presence: true
  validates :cpf, presence: true, length: {is: 11}
end

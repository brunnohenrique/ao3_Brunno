class Rent < ApplicationRecord
  belongs_to :vehicle

  validates :start_date, :end_date, presence: true
  validates :cpf, presence: true, length: {is: 11}
  validate :start_date_uniq, :end_date_uniq

  scope :by_vehicle, ->(id) { where(vehicle_id: id) }
  scope :active, -> { where("end_date >= ?" , Date.current) }

  private

  def start_date_uniq
    rents = Rent.active.by_vehicle(vehicle_id)

    dates = rents.select do |rent|
      start_date.between?(rent.start_date, rent.end_date)
    end

    errors.add(:start_date, 'Already rented at this date') unless dates.blank?
  end

  def end_date_uniq
    rents = Rent.active.by_vehicle(vehicle_id)

    dates = rents.select do |rent|
      end_date.between?(rent.start_date, rent.end_date)
    end

    errors.add(:end_date, 'Already rented at this date') unless dates.blank?
  end  
end

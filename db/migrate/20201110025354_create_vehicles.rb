class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.string :model
      t.string :manufacture
      t.string :license_plate
      t.string :model_year
      t.string :manufacture_year
      t.string :fuel_type
      t.string :color

      t.timestamps
    end
  end
end

class CreateRents < ActiveRecord::Migration[6.0]
  def change
    create_table :rents do |t|
      t.string :cpf
      t.date :start_date
      t.date :end_date
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end

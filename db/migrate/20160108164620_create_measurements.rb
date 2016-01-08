class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.string :name
      t.string :value
      t.integer :patient_id
      t.timestamps null: false
    end
  end
end

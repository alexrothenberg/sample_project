class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :preferred_phone_number
      t.timestamps null: false
    end
  end
end

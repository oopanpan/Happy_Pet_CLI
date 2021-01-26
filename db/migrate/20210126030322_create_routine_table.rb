class CreateRoutineTable < ActiveRecord::Migration[5.2]
  def change
    create_table :routines do |t|
      t.string :name
      t.string :description
      t.boolean :if_complete
      t.integer :user_id
      t.integer :pet_id
    end
  end
end

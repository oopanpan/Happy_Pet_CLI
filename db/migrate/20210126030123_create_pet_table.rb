class CreatePetTable < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name
      t.integer :age
      t.string :species
    end
  end
end

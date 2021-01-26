class RemovingFromRoutinesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :routines, :date, :datetime
    remove_column :routines, :user_id
  end
end

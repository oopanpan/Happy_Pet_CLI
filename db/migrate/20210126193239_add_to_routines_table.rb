class AddToRoutinesTable < ActiveRecord::Migration[5.2]
  def change
    add_column :routines, :on_date, :date
  end
end

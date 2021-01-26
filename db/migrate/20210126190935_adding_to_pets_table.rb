class AddingToPetsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :user_id, :integer
  end
end

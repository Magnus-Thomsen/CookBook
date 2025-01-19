class AddUserIdToRecipes < ActiveRecord::Migration[8.0]
  def change
    add_column :recipes, :user_id, :integer
    add_index :recipes, :user_id
  end
end

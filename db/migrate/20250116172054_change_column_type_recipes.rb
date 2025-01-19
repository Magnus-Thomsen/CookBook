class ChangeColumnTypeRecipes < ActiveRecord::Migration[8.0]
  def change
      change_column :recipes, :content, :jsonb
  end
end

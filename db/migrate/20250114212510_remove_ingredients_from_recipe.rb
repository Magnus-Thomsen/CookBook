class RemoveIngredientsFromRecipe < ActiveRecord::Migration[8.0]
  def change
    remove_column :recipes, :ingredients, :text
  end
end

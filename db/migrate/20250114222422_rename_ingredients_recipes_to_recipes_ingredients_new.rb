class RenameIngredientsRecipesToRecipesIngredientsNew < ActiveRecord::Migration[8.0]
  def change
    rename_table :ingredients_recipes, :recipes_ingredients
  end
end

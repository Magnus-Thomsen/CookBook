class RenameIngredientsRecipesToRecipesIngredientsNewNe < ActiveRecord::Migration[8.0]
  def change
    rename_table :recipes_ingredients, :recipe_ingredients
  end
end

class AddRelationsToIngredientsRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table "ingredients_recipes", id: false, force: :cascade do |t|
      t.integer "recipe_id", null: false
      t.integer "ingredient_id", null: false
    end    
  end
end
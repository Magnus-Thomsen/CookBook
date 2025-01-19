class AddBodyToRecipes < ActiveRecord::Migration[8.0]
  def change
    add_column :recipes, :body, :json, default: {}
  end
end

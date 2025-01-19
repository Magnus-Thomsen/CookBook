class CreateRecipes < ActiveRecord::Migration[8.0]
  def change
    create_table :recipes do |t|
      t.string :title
      t.text :ingredients
      t.text :preparation

      t.timestamps
    end
  end
end

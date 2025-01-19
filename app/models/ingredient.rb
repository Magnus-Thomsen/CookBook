class Ingredient < ApplicationRecord
    # Correct association to recipes through the join table (ingredients_recipes)
  
    validates :name, presence: true, uniqueness: true
  end
  
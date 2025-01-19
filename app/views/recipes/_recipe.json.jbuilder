json.extract! recipe, :id, :title, :ingredients, :preparation, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)

class Recipe < ApplicationRecord
    belongs_to :user
  
    has_one_attached :image do |attachable|
      attachable.variant :thumb, resize_to_fill: [1200, 900]
    end
  
    # Correct association to ingredients through the join table (ingredients_recipes)
    
    has_many :taggables, dependent: :destroy
    has_many :tags, through: :taggables
    
    extend FriendlyId
    friendly_id :slug_candidates, use: :slugged

    def slug_candidates
      [
        :title,
        [:title, :user_id],
      ]
    end

    has_many :likes, as: :likeable, dependent: :destroy
end
  

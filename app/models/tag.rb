class Tag < ApplicationRecord

    has_many :taggables, dependent: :destroy
    has_many :recipes, through: :taggables

end

class CreateTaggables < ActiveRecord::Migration[8.0]
  def change
    create_table :taggables do |t|
      t.belongs_to :recipe, null: false, foreign_key: true
      t.belongs_to :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end

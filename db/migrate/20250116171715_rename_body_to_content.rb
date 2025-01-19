class RenameBodyToContent < ActiveRecord::Migration[8.0]
  def change
    rename_column :recipes, :body, :content
  end
end

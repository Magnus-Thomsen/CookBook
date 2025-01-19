class ChangeNameToNotNullOnUsers < ActiveRecord::Migration[8.0]
  def change
    User.where(name: nil).update_all(name: 'Guest')

    change_column_null :users, :name, false
  end
  def down
    # If you rollback, we can remove the NOT NULL constraint
    change_column_null :users, :name, true
  end
end

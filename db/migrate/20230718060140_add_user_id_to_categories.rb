class AddUserIdToCategories < ActiveRecord::Migration[7.0]
  def change
    add_reference :categories, :user, null: true, foreign_key: true
  end
end

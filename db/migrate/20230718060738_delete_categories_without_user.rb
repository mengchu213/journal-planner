class DeleteCategoriesWithoutUser < ActiveRecord::Migration[7.0]
  def up
    Category.where(user_id: nil).delete_all
  end

  def down
    # Nothing to do here
  end
end

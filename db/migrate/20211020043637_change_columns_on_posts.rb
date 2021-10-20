class ChangeColumnsOnPosts < ActiveRecord::Migration[5.2]
  def change
    change_column_null :posts, :category, false
  end
end

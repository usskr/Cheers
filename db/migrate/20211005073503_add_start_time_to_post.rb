class AddStartTimeToPost < ActiveRecord::Migration[5.2]
  def up
    add_column :posts, :start_time, :datetime
    change_column :posts, :start_time, :datetime, :null => false
  end

  def down
    remove_column :posts, :start_time
  end
end

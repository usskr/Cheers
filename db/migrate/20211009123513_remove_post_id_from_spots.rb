class RemovePostIdFromSpots < ActiveRecord::Migration[5.2]
  def change
    remove_column :spots, :post_id, :integer
  end
end

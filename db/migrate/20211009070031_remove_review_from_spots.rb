class RemoveReviewFromSpots < ActiveRecord::Migration[5.2]
  def change
    remove_column :spots, :review, :text
  end
end

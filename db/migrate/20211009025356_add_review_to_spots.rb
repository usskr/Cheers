class AddReviewToSpots < ActiveRecord::Migration[5.2]
  def change
    add_column :spots, :review, :text
  end
end

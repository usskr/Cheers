class AddSpotIdToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :spot_id, :integer
  end
end

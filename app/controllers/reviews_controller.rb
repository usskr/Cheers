class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to spot_path(@review.spot)
  end

  private

  def review_params
    params.require(:review).permit(:spot_id, :user_id, :body)
  end
end

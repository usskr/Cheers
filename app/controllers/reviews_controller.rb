class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @spot = @review.spot
    @reviews = @spot.reviews
    @review.save
  end

  private

  def review_params
    params.require(:review).permit(:spot_id, :user_id, :body, :rate)
  end
end

class ReviewsController < ApplicationController
  def create
    review = Review.new(review_params)
    @spot = review.spot
    @reviews = @spot.reviews
    review.save
    @review = Review.new #非同期通信でフォームを再読み込みする時に使う
  end

  def destroy
    review = Review.find(params[:id])
    @spot = review.spot
    @reviews = @spot.reviews
    review.destroy
  end

  private

  def review_params
    params.require(:review).permit(:spot_id, :user_id, :body, :rate)
  end
end

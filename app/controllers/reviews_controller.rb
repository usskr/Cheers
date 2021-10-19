class ReviewsController < ApplicationController
  def create
    @posted_review = Review.new(review_params)
    @spot = @posted_review.spot
    @reviews = @spot.reviews.page(params[:page]).reverse_order
    unless @posted_review.save
      render :error
    end
    @review = Review.new # 非同期通信でフォームを再読込する時に使う
  end

  def destroy
    review = Review.find(params[:id])
    @spot = review.spot
    @reviews = @spot.reviews.page(params[:page]).reverse_order
    review.destroy
  end

  private

  def review_params
    params.require(:review).permit(:spot_id, :user_id, :body, :rate)
  end
end

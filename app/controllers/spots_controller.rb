class SpotsController < ApplicationController
  def index
    @spots = Spot.all.page(params[:page]).reverse_order
    gon.spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
    @lat = @spot.latitude
    @lng = @spot.longitude
    gon.lat = @lat
    gon.lng = @lng
    @reviews = @spot.reviews.page(params[:page]).reverse_order
    @review = Review.new
  end
end

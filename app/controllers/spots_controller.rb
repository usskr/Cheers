class SpotsController < ApplicationController
  def index
    @spots = Spot.all.order(id: "DESC")
    gon.spots = Spot.all
  end

  def show
    @spot = Spot.find(params[:id])
    @lat = @spot.latitude
    @lng = @spot.longitude
    gon.lat = @lat
    gon.lng = @lng
    @reviews = @spot.reviews.order(id: "DESC")
    @review = Review.new
  end
end

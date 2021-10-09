class SpotsController < ApplicationController
  def index
    @spots = Spot.all
    # @spots = Spot.select(:address).distinct
  end

  def show
    # @spots = Spot.where(address: params[:address])
    @spot = Spot.find(params[:id])
    @reviews = @spot.reviews
    @lat = @spot.latitude
    @lng = @spot.longitude
    gon.lat = @lat
    gon.lng = @lng
  end
end

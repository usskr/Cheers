class Spot < ApplicationRecord
  has_many :posts
  geocoded_by :address
  after_validation :geocode
  has_many :reviews
end

class Review < ApplicationRecord
  belongs_to :spot
  belongs_to :user

  validates :body, presence: true, length: { maximum: 200 }
  validates :rate, presence: true
end

class Post < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :cheers, dependent: :destroy
  has_one :spot, dependent: :destroy
  accepts_nested_attributes_for :spot
  # has_many :cheered_users, through: :cheers, source: :user

  def cheered_by?(user)
    cheers.where(user_id: user.id).exists?
  end

  enum category: { 食事: 0, 運動: 1, おすすめ: 2, 失敗談: 3 }

  def self.search(keyword)
    where(["content like?", "%#{keyword}%"])
  end
end

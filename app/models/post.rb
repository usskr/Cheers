class Post < ApplicationRecord
  attachment :image
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :cheers, dependent: :destroy
  belongs_to :spot, optional: true # spotを持たないpostを作成できる

  def cheered_by?(user)
    cheers.where(user_id: user.id).exists?
  end

  enum category: { 食事: 0, 運動: 1, おすすめ: 2, 失敗談: 3 }

  def self.search(keyword)
    post_ids_belongs_to_spot = []
    spots = Spot.where("address like ?", "%#{keyword}%")
    if !spots.nil?
      spots.each do |spot|
        post_ids_belongs_to_spot.concat(spot.posts.ids) # concat：配列を連結
      end
    end
    post_ids_includes_content = Post.where("content like ?", "%#{keyword}%").ids
    Post.where(id: [*post_ids_belongs_to_spot, *post_ids_includes_content])
  end

  validates :category, presence: true
  validates :content, presence: true, length: { maximum: 200 }
end

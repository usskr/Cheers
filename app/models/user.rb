class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :profile_image
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :cheers, dependent: :destroy
  has_many :reviews, dependent: :destroy

  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :user_rooms, dependent: :destroy

  has_many :reverse_of_relationships, class_name: "Relationship",
                                      foreign_key: "followed_id", dependent: :destroy
  has_many :relationships, class_name: "Relationship",
                           foreign_key: "follower_id", dependent: :destroy
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :followings, through: :relationships, source: :followed

  def follow(user_id)
    relationships.create(followed_id: user_id)
  end

  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

  before_save { email.downcase! }
  validates :name, uniqueness: true, length: { minimum: 2, maximum: 10 }
  validates :introduction, length: { maximum: 100 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
end

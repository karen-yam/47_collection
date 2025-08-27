class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 800 }
  validates :prefecture_id, uniqueness: { scope: :user_id, message: "は既に投稿済みです" }
  validates :image, presence: true

  belongs_to :user
  belongs_to :prefecture
  belongs_to :category

  mount_uploader :image, ImageUploader
end

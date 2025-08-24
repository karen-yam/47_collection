class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { maximum: 800 }

  belongs_to :user
  belongs_to :prefecture
  belongs_to :category

  mount_uploader :image, ImageUploader
end

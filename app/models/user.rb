class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :recoverable

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, uniqueness: true

  has_many :posts, dependent: :destroy

  def posted_prefecture_count
    posts.select(:prefecture_id).distinct.count
  end
end

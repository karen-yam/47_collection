class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, uniqueness: true

  has_many :posts, dependent: :destroy
end

class Prefecture < ApplicationRecord
  has_many :posts
  validates :name, uniqueness: true, presence: true
end

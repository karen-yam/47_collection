class Prefecture < ApplicationRecord
  has_many :posts
  validates :name, uniqueness: true, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name" ]
  end
end

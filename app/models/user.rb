class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :recoverable, :omniauthable, omniauth_providers: [ :google_oauth2 ]

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, uniqueness: true
  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }

  scope :published, -> { where(is_published: true) }
  scope :unpublished, -> { where(is_published: false) }

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy

  def posted_prefecture_count
    posts.select(:prefecture_id).distinct.count
  end

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
    end
  end

  def self.create_unique_string
    SecureRandom.uuid
  end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable, :recoverable, :omniauthable, omniauth_providers: [ :google_oauth2 ]

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, uniqueness: true
  validates :bio, length: { maximum: 100 }
  validates :uid, presence: true, uniqueness: { scope: :provider }, if: -> { uid.present? }

  scope :published, -> { where(is_published: true) }
  scope :unpublished, -> { where(is_published: false) }

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  def posted_prefecture_count
    posts.distinct.count(:prefecture_id)
  end

  attr_accessor :newly_registered

  def self.from_omniauth(auth)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    if user.new_record?
      user.email            = auth.info.email
      user.password         = Devise.friendly_token[0, 20]
      user.name             = auth.info.name
      user.is_published     = false
      user.newly_registered = true
      user.save
    end
    user
  end

  def self.create_unique_string
    SecureRandom.uuid
  end

  def own?(object)
    id == object&.user_id
  end

  def like(post)
    liked_posts << post
  end

  def unlike(post)
    liked_posts.destroy(post)
  end

  def like?(post)
    liked_posts.include?(post)
  end
end

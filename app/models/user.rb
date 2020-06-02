class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i(facebook twitter google_oauth2)

  has_many :image_posts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :image_post_likes
  has_many :like_image_posts, through: :image_post_likes, source: :image_post
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, length: { maximum: 255 }
  validates :introduction, length: { maximum: 200 }

  def self.from_omniauth(auth)
    # Omniauth認証するたびに認証先ユーザー情報（名前など）が取得される。
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.name = auth.info.name
    user
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com', name: 'UserGuest') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

  # deviseのupdate_without_passwordを参考に
  def update_without_current_password(params)
    params.delete(:current_password)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params)
    clean_up_passwords
    result
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def image_like(image_post)
    like_image_posts << image_post
  end

  def image_unlike(image_post)
    image_post_likes.find_by(image_post_id: image_post.id).destroy
  end

  def image_like?(image_post)
    like_image_posts.include?(image_post)
  end
end

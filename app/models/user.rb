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
  has_many :image_post_likes, dependent: :destroy
  has_many :liked_image_posts, through: :image_post_likes, source: :image_post
  has_many :comments, dependent: :destroy
  has_many :recruitments, dependent: :destroy
  has_many :recruitment_likes, dependent: :destroy
  has_many :liked_recruitments, through: :recruitment_likes, source: :recruitment
  has_many :messages, dependent: :destroy
  has_many :active_notifications, class_name: "Notification",
                                  foreign_key: "visitor_id",
                                  dependent: :destroy
  has_many :passive_notifications, class_name: "Notification",
                                   foreign_key: "visited_id",
                                   dependent: :destroy
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, length: { maximum: 255 }
  validates :introduction, length: { maximum: 200 }
  validate :picture_size
  PICTURE_SIZE = [110, 110].freeze
  mount_uploader :picture, PictureUploader

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
    liked_image_posts << image_post
  end

  def image_unlike(image_post)
    image_post_likes.find_by(image_post_id: image_post.id).destroy
  end

  def image_like?(image_post)
    liked_image_posts.include?(image_post)
  end

  def recruitment_like(recruitment)
    liked_recruitments << recruitment
  end

  def recruitment_unlike(recruitment)
    recruitment_likes.find_by(recruitment_id: recruitment.id).destroy
  end

  def recruitment_like?(recruitment)
    liked_recruitments.include?(recruitment)
  end

  def create_follow_notification(current_user)
    temp = passive_notifications.where(
      "visitor_id = ? and action = ?", current_user.id, 'follow'
    )
    if temp.blank?
      notification = current_user.active_notifications.build(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  private

  def picture_size
    if picture.size > 2.megabytes
      errors.add(:picture, "画像は2MB未満にしてください")
    end
  end
end

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
end

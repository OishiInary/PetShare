class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :image

  enum gender: {other: 0, male: 1, female: 2}
  enum hope: {nom: 0, req: 1, can: 2}

  validates :name,presence: { message: "の入力は必須です", full_message:false},length: { minimum: 2, maximum: 20 }
  validates :address, presence: true
  validates :gender, presence: true
  validates :post_code, presence: true,length: {is: 7 }
  validates :phone, presence: true,length: { minimum: 10, maximum: 11 }
  validates :birthday, presence: true
  validates :hope, presence: true

  has_many :pets, dependent: :destroy
  has_many :albums, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :favorites, dependent: :destroy
  has_many :pet_favorites, dependent: :destroy

  has_many :active_relationships,  class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :user_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :rooms, through: :user_rooms

  has_many :group_user, dependent: :destroy
  has_many :group_chat, dependent: :destroy

  has_many :followings, through: :active_relationships,  source: :followed
  has_many :followers,  through: :passive_relationships, source: :follower
  # ゲスト用のメルアド
  GUEST_USER_EMAIL = "guest@exsample.com"
# Eメールがゲストようだったらゲストユーザー認定
  def guest_user?
    email == GUEST_USER_EMAIL
  end

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
      user.address = "ゲストユーザーに住所は存在しません"
      user.post_code = "1234567"
      user.phone = "1234567890"
      user.gender = 0
      user.hope = 0
      user.birthday = Date.new(1999, 1, 1)
      user.introduction = "サンプルユーザーです。"
    end
  end
   
  
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end

  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end

# ユーザーに関連付けられたペットの取得
  def mypets
   self.pets
  end

# ユーザー画像取得処理
  def get_profile_image
    (image.attached?) ? image : '/no_image.jpg'
  end

  def self.search_for(content, method)
    if method == 'perfect'
      User.where(name: content)
    else
      User.where('name LIKE ?', '%' + content + '%')
    end
  end

end

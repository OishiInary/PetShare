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
  validates :post_code, presence: true
  validates :phone, presence: true
  validates :birthday, presence: true
  validates :hope, presence: true
  validates :is_active, presence: true
         
  has_many :pets, dependent: :destroy    
  has_many :albums, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :pet_favorites, dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy
  has_many :group_users, dependent: :destroy, dependent: :destroy
  has_many :group_chats, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  has_many :active_relationships,  class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  
  has_many :followings, through: :active_relationships,  source: :followed
  has_many :followers,  through: :passive_relationships, source: :follower
  
  def follow(user)
    active_relationships.create(followed_id: user.id)
  end
  
  def unfollow(user)
    active_relationships.find_by(followed_id: user.id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
  
  def mypets
   self.pets
  end
  

end

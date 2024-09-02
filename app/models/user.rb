class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :image
  
  enum gender: {other: 0 , male: 1, female: 2}
  enum type: {nom: 0 , req: 1, can: 2}
  
  validates :name,presence: { message: "の入力は必須です", full_message:false}
  validates :image, presence: true
  validates :address, presence: true
  validates :introduction, presence: true
  validates :gender, presence: true
  validates :post_code, presence: true
  validates :phone, presence: true
  validates :birthday, presence: true
  validates :type, presence: true
  validates :is_active, presence: true
         
  has_many :pets, dependent: :destroy    
  has_many :albums, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :pet_favorites, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :group_chats, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :entries, dependent: :destroy
  has_many :messages, dependent: :destroy
end

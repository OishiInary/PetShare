class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_one_attached :image
         
  validates :name,presence: { message: "の入力は必須です", full_message:false}
         
         
  has_many :pets, dependent: :destroy    
  has_many :album, dependent: :destroy
  has_many :comment, dependent: :destroy
  has_many :favorites, dependent: :destroy
end

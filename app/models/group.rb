class Group < ApplicationRecord
  has_many :users, through: :group_users, source: :user
  has_many :group_user, dependent: :destroy
  has_many :group_chat, dependent: :destroy
  belongs_to :owner, class_name: "User"
  has_one_attached :group_image
  
  validates :name, presence: true
  validates :introduction, presence: true
  
  
  def include_user?(user)
    group_user.exists?(user_id: user.id)
  end
  
  def get_image
    (group_image.attached?) ? group_image : 'no_image.jpg'
  end
  
end
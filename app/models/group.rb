class Group < ApplicationRecord
  # アソシエーション
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users, source: :user
  has_many :group_chats, dependent: :destroy # 名前を修正
  belongs_to :owner, class_name: "User"
  has_one_attached :group_image

  # バリデーション
  validates :name, presence: true, length: { minimum: 2, maximum: 20 }
  validates :introduction, presence: true, length: { minimum: 2, maximum: 150 }

  # メソッド
  def include_user?(user)
    group_users.exists?(user_id: user.id)
  end

  def get_image
    group_image.attached? ? group_image : '/no_image.jpg'
  end
end
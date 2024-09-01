class Album < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :pet
  belongs_to :tag
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  def self.last_week #週間でいいねが高いランキングを作る
    # Album.joins(:favorites).where(favorites:{ created_at:0.days.ago.prev_week..0.days.ago.prev_week(:sunday)}).group(:id).order("count(*) desc")
  end
end

class ViewCount < ApplicationRecord
  belongs_to :user
  belongs_to :album
end

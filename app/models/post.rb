class Post < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :spot
  belongs_to :member
end

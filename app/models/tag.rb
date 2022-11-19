class Tag < ApplicationRecord
  has_many :tag_posts, dependent: :destroy

  validates :tag_name, presence: true
end

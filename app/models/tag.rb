class Tag < ApplicationRecord
  has_many :tag_posts, dependent: :destroy
end

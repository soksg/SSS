class PostComment < ApplicationRecord
  has_many :members
  has_many :posts
end

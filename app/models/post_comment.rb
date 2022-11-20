class PostComment < ApplicationRecord

  belongs_to :member
  belongs_to :post
  has_one :post_comment_review

  validates :comment, presence: true
end




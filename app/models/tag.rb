class Tag < ApplicationRecord
  has_many :tag_posts, dependent: :destroy, foreign_key: 'tag_id'
  # タグは複数の投稿を持ち、post_tagsを通じて参照できる
  has_many :posts, through: :tag_posts

  validates :name, uniqueness: true, presence: true

end

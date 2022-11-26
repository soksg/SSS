class PostComment < ApplicationRecord
  # save直前にメソッドを呼ぶ
   before_save :set_star_value

  belongs_to :member
  belongs_to :post

  validates :comment, presence: true


  # レビューのスターがnilであれば、０を代入する
  def set_star_value
      self.star = 0 if self.star.nil?
  end

end






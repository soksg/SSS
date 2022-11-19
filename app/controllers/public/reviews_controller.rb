class Public::ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
  end

  private
  def review_params
    params.require(:review).permit(:post_id, :score, :content)
  end
end
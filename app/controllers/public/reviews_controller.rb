class Public::ReviewsController < ApplicationController

  private
  def review_params
    params.require(:review).permit(:member_id, :post_id, :star, :comment)
  end
end

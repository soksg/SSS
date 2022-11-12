class Public::BookmarksController < ApplicationController


  private
  def bookmark_params
    params.require(bookmark).permit(:member_id, :post_id)
  end

end

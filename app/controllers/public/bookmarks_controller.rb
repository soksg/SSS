class Public::BookmarksController < ApplicationController
  before_action :authenticate_current_member!


  private
  def bookmark_params
    params.require(bookmark).permit(:member_id, :post_id)
  end

end

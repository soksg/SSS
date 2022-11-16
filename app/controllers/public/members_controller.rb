class Public::MembersController < ApplicationController
    # before_action :authenticate_current_member!

    def bookmarks
      @member=Member.find(params[:id])
      bookmarks=Bookmark.where(member_id: @member.id).pluck(:post_id)
      @bookmark_posts=Post.find(bookmarks)
    end

  private
  def member_params
    params.require(member).permit(:email, :encrypted_password, :name, :is_active)
  end

end

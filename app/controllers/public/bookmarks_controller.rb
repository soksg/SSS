class Public::BookmarksController < ApplicationController
  before_action :authenticate_member!
  def create
    # if member_signed_in?
      @post=Post.find(params[:post_id])
      bookmark=current_member.bookmarks.new(post_id: @post.id)
      bookmark.save

      # byebug

    # else
    #   redirect_to new_member_session_path
    # end
  end

  def destroy
    @post=Post.find(params[:post_id])
    bookmark=current_member.bookmarks.find_by(post_id: @post.id)
    bookmark.destroy
  end

end

class Public::BookmarksController < ApplicationController

  def create
    if member_signed_in?
      post=Post.find(params[:post_id])
      bookmark=current_member.bookmarks.new(post_id: post.id)
      bookmark.save
      redirect_to request.referer
    else
      redirect_to new_member_session_path
    end
  end

  def destroy
    post=Post.find(params[:post_id])
    bookmark=current_member.bookmarks.find_by(post_id: post.id)
    bookmark.destroy
    redirect_to request.referer
  end

end

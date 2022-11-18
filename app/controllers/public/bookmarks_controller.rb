class Public::BookmarksController < ApplicationController
  before_action :authenticate_member!
  def create
      @post=Post.find(params[:post_id])
      bookmark=current_member.bookmarks.new(post_id: @post.id)
      bookmark.save
  end

  def destroy
    @post=Post.find(params[:post_id])
    bookmark=current_member.bookmarks.find_by(post_id: @post.id)
    bookmark.destroy
  end

end

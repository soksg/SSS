class Public::PostCommentsController < ApplicationController
  before_action :authenticate_member!
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_member.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
      flash[:notice] = 'レビューを投稿しました'
    else
      render post_path(@post)
      flash[:alert] = 'レビューの投稿に失敗しました'
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    flash[:alert] = 'レビューを削除しました'
    @post = Post.find(params[:post_id])
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment, :star)
  end
end

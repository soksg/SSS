class Public::PostCommentsController < ApplicationController
  before_action :authenticate_member!
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_member.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    if @post_comment.save
      flash.now[:notice] = 'レビューを投稿しました'
      #非同期化のため、追記
      @post_comment_new=PostComment.new
      render "public/comments/create"
    else
      render post_path(@post)
      flash.now[:alert] = 'レビューの投稿に失敗しました'
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    flash.now[:alert] = 'レビューを削除しました'
    @post = Post.find(params[:post_id])
    #destroy.jsで使う変数を定義する
    @post_comment=PostComment.new
    render "public/comments/destroy"
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment, :star)
  end
end

class Public::PostCommentsController < ApplicationController
  # before_action :authenticate_member!

  def create
    @post = Post.find(params[:post_id])
    @post_comment = PostComment.new(post_comment_params)
    @post_comment.post_id = @post.id
    @comment_error = ''
    if member_signed_in?
      @post_comment.member_id = current_member.id
      if @post_comment.save
        @post_comment = PostComment.new(post_id: @post, member_id: current_member.id)
        flash.now[:notice] = 'レビューを投稿しました'
        #非同期化のため、追記
        #@post_comment_new = PostComment.new
        render "public/comments/create"
      else
        flash.now[:alert] = 'レビュー内容を入力してください'
        render "public/comments/create"
      end
    else
        redirect_to member_session_path
    end
  end

  def destroy
    PostComment.find(params[:id]).destroy
    flash.now[:notice] = 'レビューを削除しました'
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

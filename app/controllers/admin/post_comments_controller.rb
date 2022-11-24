class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    PostComment.find(params[:id]).destroy
    flash.now[:alert] = 'レビューを削除しました'
    @post = Post.find(params[:post_id])
    #destroy.jsで使う変数を定義する
    @post_comment=PostComment.new
    render "admin/comments/destroy"
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment, :star)
  end
end

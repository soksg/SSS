class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_member.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id

    if  @post_comment.save
      flash.now[:notice] = 'コメントを投稿しました'
    else
      render post_path(@post)
      flash.now[:alert] = 'コメントの投稿に失敗しました'
    end
  end

  def destroy
    Comment.find_by(id: params[:id], post_id: params[:post_id]).destroy
    flash.now[:alert] = '投稿を削除しました'
  end












  def destroy
    PostComment.find(params[:id]).destroy
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end

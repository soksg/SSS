class Public::PostCommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_member.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id

    if  @post_comment.save
      flash.now[:notice] = 'コメントを投稿しました'
      #render :create

    else
      # render post_path(@post)
      # flash.now[:alert] = 'コメントの投稿に失敗しました'
    end
    @comment = current_member.post_comments.new(post_comment_params)
    @comment.post_id = post.id
    @comment.save
    redirect_to request.referer
  end

  def destroy
    PostComment.find(params[:id]).destroy
    flash.now[:alert] = '投稿を削除しました'
    @post = Post.find(params[:post_id])
  end

  private
  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end

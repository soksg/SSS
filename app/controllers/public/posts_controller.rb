class Public::PostsController < ApplicationController
  def new
    @post=Post.new
  end

  def create
    @post=Post.new(post_params)
    @post.member_id=current_member.id
    if  @post.save
        redirect_to post_path(@post), notice: "投稿しました"
    else
        @post=Post.new
        render "new"
    end
  end

  def index
    @post=Post.all
  end

  def show
    @post=Post.find(params[:id])
  end

  def edit
    @post=Post.find(params[:id])
  end

  def update
    @post=Post.find(params[:id])
    if  @post.update(post_params)
        redirect_to posts_path, notice: "投稿内容を更新しました"
    else
        render "edit"
    end
  end

  def destroy
    @post=Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  private
  def post_params
    params.require(:post).permit(:member_id, :spot_id, :image)
  end
end

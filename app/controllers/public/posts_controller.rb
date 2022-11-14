class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]

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
    @posts=Post.all
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
        redirect_to post_path(@post), notice: "投稿内容を更新しました"
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
    params.require(:post).permit(:member_id, :name, :address, :longitude, :latitude, :url, :phone_number, :opening_hour, :description, :image)
  end
end

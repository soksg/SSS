class Public::PostsController < ApplicationController
  def new
    @post=Post.new
    @spot=Spot.new
  end

  def create
    @post=Post.new(post_params)
    @post.member_id=current_member.id
    @post.save
    redirect_to posts_path
    # @spot=Spot.new()
  end

  def index
    @posts=Post.all
  end

  def show
    @post=Post.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(post).permit(:member_id, :spot_id, :image)
  end
end

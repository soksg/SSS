class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @posts = Post.is_active.page(params[:page]).per(7)
    @posts = @posts.where("posts.name LIKE ?", "%#{params[:word]}%") if params[:word].present?
    @posts = @posts.where(prefecture: params[:prefecture]) if params[:prefecture].present?
    @tag_list = Tag.all
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    if @post.post_comments.present?
      @reviews_avg_score = @post.post_comments.sum(:star) / @post.post_comments.count
    else
      @reviews_avg_score = 0
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path, alert: "投稿を削除しました"
  end

  private
  def post_params
    params.require(:post).permit(:member_id, :name, :address, :longitude, :latitude, :url, :phone_number, :opening_hour, :description, :prefecture, :image)
  end
end

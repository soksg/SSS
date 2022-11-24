class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show, :search_tag]
  before_action :correct_post, only: [:edit]

  def new
    @post=Post.new
  end

  def create
    @post=Post.new(post_params)
    @post.member_id=current_member.id
    # 受け取った値を,で区切って配列にする
    byebug
    tag_list=params[:tags].split
    # tag_list=params[:tags].split

    if  @post.save
        @post.save_tag(tag_list)
        redirect_to post_path(@post), notice: "投稿しました"
    else
        @post=Post.new
        render "new", alert: "項目を入力してください"
    end
  end

  def index
    @posts = Post.is_active
    @posts = @posts.where("posts.name LIKE ?","%#{params[:word]}%") if params[:word].present?
    @tag_list=Tag.all
  end

  def show
    @post=Post.find(params[:id])
    @post_comment=PostComment.new
    @post_tags = @post.tags
    if @post.post_comments.present?
      @reviews_avg_score = @post.post_comments.sum(:star) / @post.post_comments.count
    else
      @reviews_avg_score = 0
    end
  end

  def edit
    @post=Post.find(params[:id])
    # pluckはmapと同じ意味
    @tag_list=@post.tags.pluck(:name).join(',')
  end

  def update
    @post=Post.find(params[:id])
    tag_list=params[:post][:name].split(',')
    if  @post.update(post_params)
    　　  @post.save_tag(tag_list)
     　  redirect_to post_path(@post), notice: "投稿内容を更新しました"
    else
        render "edit", alert: "項目を入力してください"
    end
  end


  def destroy
    @post=Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
    flash[:alert] = '投稿を削除しました'
  end

  private
  def post_params
    params.require(:post).permit(:member_id, :name, :address, :longitude, :latitude, :url, :phone_number, :opening_hour, :description, :image)
  end

  def correct_post
    @post=Post.find(params[:id])
    unless @post.member.id==current_member.id
      redirect_to posts_path, alert: '他ユーザーの投稿は編集できません'
    end
  end
end




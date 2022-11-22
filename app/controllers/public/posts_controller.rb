class Public::PostsController < ApplicationController
  before_action :authenticate_member!, except: [:index, :show]

  def new
    @post=Post.new
  end

  def create
    @post=Post.new(post_params)
    @post.member_id=current_member.id
    # 受け取った値を,で区切って配列にする
    tag_list=params[:tags].split(',')
    if  @post.save
        @post.save_tag(tag_list)
        redirect_to post_path(@post), notice: "投稿しました"
    else
        @post=Post.new
        render "new", notice: "項目を入力してください"
    end
  end

  def index
    @posts = Post.is_active
    @posts = @posts.where("name LIKE?","%#{params[:word]}%") if params[:word].present?
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
        render "edit", notice: "項目を入力してください"
    end
  end

   def search_tag
    #検索結果画面でもタグ一覧表示
    @tag_list=Tag.all
    #検索されたタグを受け取る
    @tag=Tag.find(params[:tag_id])
    @tag.posts
    #検索されたタグに紐づく投稿を表示
    @posts=@tag.posts
  end

  def destroy
    @post=Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
    flash[:notice] = '投稿を削除しました'
  end

  private
  def post_params
    params.require(:post).permit(:member_id, :name, :address, :longitude, :latitude, :url, :phone_number, :opening_hour, :description, :image)
  end
end




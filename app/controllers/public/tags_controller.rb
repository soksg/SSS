class Public::TagsController < ApplicationController
  def show
    #検索結果画面でもタグ一覧表示
    @tag_list=Tag.all
    #検索されたタグを受け取る
    @tag=Tag.find(params[:id])
    @tag.posts
    #検索されたタグに紐づく投稿を表示
    @posts=@tag.posts.is_active.page(params[:page]).per(7)
  end
end

class Public::MembersController < ApplicationController
  before_action :authenticate_member!
  before_action :correct_member, only: [:show, :edit, :bookmarks]
  before_action :ensure_guest_member, only: [:edit, :withdraw]

  def show
    @member=Member.find(params[:id])
    @posts=@member.posts
    @tag_list=Tag.all
  end

  def edit
    @member=Member.find(params[:id])
  end

  def update
    @member=Member.find(params[:id])
    if @member.update(member_params)
       redirect_to member_path(@member), notice: "プロフィールを更新しました"
    else
       render 'edit', alert: "項目を入力してください"
    end
  end

  def bookmarks
    @member=Member.find(params[:id])
    bookmarks=Bookmark.where(member_id: @member.id).pluck(:post_id)
    @bookmark_posts=Post.find(bookmarks)
    @tag_list=Tag.all
  end

  def guest_sign_in
    member = Member.guest
    sign_in member
    redirect_to member_path(member), notice: 'ゲストメンバーでログインしました。'
  end

  def unsubscribe
  end

  def withdraw
    @member = current_member
    # is_activeカラムをfalseに変更することにより削除フラグを立てる
    @member.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  private
  def member_params
    params.require(:member).permit(:name, :email, :encrypted_password, :is_active)
  end

  def ensure_guest_member
  @member = Member.find(params[:id])
    if @member.name == "guestuser"
      redirect_to member_path(current_member) , notice: 'ゲストメンバーはプロフィール編集画面へ遷移できません。'
    end
  end

  def correct_member
    @member=Member.find(params[:id])
    unless @member.id == current_member.id
       redirect_to posts_path, alert: '他ユーザーのページは見れません'
    end
  end

end

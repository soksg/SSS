class Public::MembersController < ApplicationController
    before_action :authenticate_member!, except:[:show]

    def show
      @member=Member.find(params[:id])
      @posts=@member.posts
    end

    def edit
      @member=Member.find(params[:id])
    end

    def update
      @member=Member.find(params[:id])
      if @member.update(member_params)
         redirect_to member_path(@member)
      else
         render 'update'
      end

    end

    def bookmarks
      @member=Member.find(params[:id])
      bookmarks=Bookmark.where(member_id: @member.id).pluck(:post_id)
      @bookmark_posts=Post.find(bookmarks)
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

end

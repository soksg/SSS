class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @members = Member.page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
    @posts=@member.posts.page(params[:page]).per(7)
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
       redirect_to admin_member_path, notice: "ユーザー情報を更新しました"
    else
       flash.now[:alert] = "項目を入力してください"
       render 'edit'
    end
  end

  private

  def member_params
    params.require(:member).permit(:name ,:encrypted_password, :email, :is_active)
  end
end

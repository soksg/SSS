# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action  :member_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected
  # 退会しているかを判断するメソッド
  def member_state
    # 入力されたメールアドレスからアカウントを一件取得
    @member=Member.find_by(email: params[:member][:email])
    return if !@member
      flash[:alert] = "該当するアカウントが見つかりません"
    # valid_password?で、特定のアカウントのパスワードと入力されたパスワードが一致しているかを確認する(deviseのメソッド)
    if @member.valid_password?(params[:member][:password]) && (@member.is_active == false)
      redirect_to new_member_registration_path
    else
      flash[:alert] = "項目を入力してください"
    end
  end

  def after_sigin_in_path_for(resource)
    posts_path
  end

  def after_sigin_out_path_for(resource)
    posts_path
  end

  # 会員の論理削除のための記述。退会後のログインを阻止。
  def reject_user
    @member=Member.find_by(name: params[:member][:name])
    if @member
      if @member.valid_password?(params[:member][:password]) && (@member.is_deleted == false)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください。"
        redirect_to root_path
      else
        flash[:alert] = "項目を入力してください"
      end
    end
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

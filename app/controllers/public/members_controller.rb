class Public::MembersController < ApplicationController
    before_action :authenticate_current_member!

  private
  def member_params
    params.require(member).permit(:email, :encrypted_password, :last_name, :first_name, :last_name_kana, :first_name_kana, :is_active)
  end

end

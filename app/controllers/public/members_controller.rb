class Public::MembersController < ApplicationController
    # before_action :authenticate_current_member!

    def show
      @member=Member.find(params[:id])
      @posts=@member.posts
    end

    def edit
      @member=Member.find(params[:id])
    end

    def update
      @member=Member.find
      @member.update
    end

    def bookmarks
      @member=Member.find(params[:id])
      bookmarks=Bookmark.where(member_id: @member.id).pluck(:post_id)
      @bookmark_posts=Post.find(bookmarks)
    end

  private
  def member_params
    params.require(member).permit(:email, :encrypted_password, :name, :is_active)
  end

end

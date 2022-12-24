class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  validates :email, presence: true
  validates :name, presence: true

  # ゲストメンバー設定
  def self.guest
    # 条件を指定して初めの1件を取得し1件もなければ作成
    find_or_create_by!(name: 'guestmember' ,email: 'guest@example.com') do |member|
      # ランダムで URL-safe(URLとして扱える) な base64 (64進数でできた)文字列を生成して返す
      member.password = SecureRandom.urlsafe_base64
      member.name = "guestmember"
    end
  end

  # is_activeがtrueならfalseを返す（退会ユーザーはログインできないようにする）
  def active_for_authentication?
   is_active == true
  end

end
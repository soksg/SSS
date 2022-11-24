class Post < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  belongs_to :member

  # タグのリレーションのみ記載
  has_many :tag_posts, dependent: :destroy
  has_many :tags, through: :tag_posts, dependent: :destroy

  scope :is_active, -> { includes(:member).where(members: {is_active: true}) }
  # includes　postsテーブルとmembersのmembers: {is_active: true}をつなげる
  # 上記は、以下と同義。->はdef〜endの役割
  # def self.is_active
  #   self.includes(:member).where(members: {is_active: true})
  # end


  validates :name, presence: true
  validates :address, presence: true
  validates :url, presence: true
  validates :phone_number, presence: true
  validates :opening_hour, presence: true

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  has_one_attached :image




  def get_image(width,height)
    unless image.attached?
      file_path=Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image.variant(resize_to_limit:[width,height]).processed
  end

  def bookmarked_by?(member)
    if member.present?
       bookmarks.exists?(member_id: member.id)
    end
  end
  #ブックマーク条件分岐で使用
  def bookmarked(member)
    bookmarks.find_by(member_id: member.id)
  end

  def save_tag(sent_tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてoldtagとする
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = sent_tags - current_tags

    # 古いタグを消す
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    # 新しいタグを保存
    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end
  end



  # 検索機能で使用→posts_controller.erbのindexアクションに記載
  # def self.looks(word)
  #   Post.where("name LIKE?","%#{word}%")
  # end

end

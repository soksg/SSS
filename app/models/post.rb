class Post < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :member
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

end

class Post < ApplicationRecord
  belongs_to :post_type
  has_many :images
  validates_presence_of :title, :body

  after_save :check_for_banner_images

  protected

  def check_for_banner_images
    if images.any? && images.where(is_banner: true).count == 0
      images.first.update(is_banner: true)
    end
  end
end

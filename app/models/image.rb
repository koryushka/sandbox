class Image < ApplicationRecord
  mount_uploader :upload, ImageUploader
  belongs_to :post
  after_save :reset_other_images_is_banner_property

  def url
    upload.url
  end

  protected

  def reset_other_images_is_banner_property
    banner_images = post.images.where.not(id: self.id).where(is_banner: true)
    banner_images.update_all(is_banner: false) if banner_images.any? && is_banner  
  end
end

class AddIsBannerToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :is_banner, :boolean, default: false
  end
end

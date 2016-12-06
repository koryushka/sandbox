class RemoveBannerFromPosts < ActiveRecord::Migration[5.0]
  def change
    remove_column :posts, :banner, :string
  end
end

class AddBannerToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :banner, :string
  end
end

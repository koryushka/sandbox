class AddPostTypeIdToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :post_type_id, :integer
  end
end

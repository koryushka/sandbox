class AddLinkToImages < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :link, :string
  end
end

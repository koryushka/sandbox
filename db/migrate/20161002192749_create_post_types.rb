class CreatePostTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :post_types do |t|
      t.string :name

      t.timestamps
    end
    add_index :post_types, :name, unique: true
  end
end

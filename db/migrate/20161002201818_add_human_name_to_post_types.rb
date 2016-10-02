class AddHumanNameToPostTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :post_types, :human_name, :string
  end
end

class RenamePictureToUploadToImages < ActiveRecord::Migration[5.0]
  def change
    rename_column :images, :picture, :upload
  end
end

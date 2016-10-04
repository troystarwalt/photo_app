class AddAdminIdToPhotos < ActiveRecord::Migration
  def change
    add_column :photos, :admin_id, :integer
  end
end

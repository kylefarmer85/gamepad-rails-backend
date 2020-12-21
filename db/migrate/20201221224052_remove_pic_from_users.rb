class RemovePicFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :pic, :string
  end
end

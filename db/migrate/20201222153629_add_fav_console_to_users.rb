class AddFavConsoleToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :fav_console, :string
  end
end

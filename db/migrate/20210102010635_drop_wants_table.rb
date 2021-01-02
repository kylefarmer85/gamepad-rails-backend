class DropWantsTable < ActiveRecord::Migration[6.0]
  def up
    drop_table :wants
  end

  def down
    fail ActiveRecord::IrreversibleMigration
  end
end

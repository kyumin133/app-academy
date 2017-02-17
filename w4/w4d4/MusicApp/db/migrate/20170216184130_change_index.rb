class ChangeIndex < ActiveRecord::Migration
  def change
    remove_index :albums, [:band_id, :name]
    add_index :albums, :name, unique: true
  end
end

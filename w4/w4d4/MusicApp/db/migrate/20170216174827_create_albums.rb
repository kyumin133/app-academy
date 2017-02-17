class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :band_id, null: false
      t.string :name, null: false
      t.string :live_studio, null: false

      t.timestamps null: false
    end

    add_index :albums, [:band_id, :name], unique: true
  end
end

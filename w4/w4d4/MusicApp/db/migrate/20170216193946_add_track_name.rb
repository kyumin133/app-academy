class AddTrackName < ActiveRecord::Migration
  def change
    add_column :tracks, :name, :string, null: false, unique: true
  end
end

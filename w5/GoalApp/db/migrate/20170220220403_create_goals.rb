class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :name, null: false
      t.integer :user_id, null: false
      t.boolean :private, default: false, null: false
      t.timestamps null: false
    end
    add_index :goals, :user_id
  end
end

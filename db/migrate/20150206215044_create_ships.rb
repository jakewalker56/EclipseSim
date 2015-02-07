class CreateShips < ActiveRecord::Migration
  def change
    create_table :ships do |t|
      t.string :name
      t.integer :targetting
      t.integer :hull
      t.integer :shield
      t.integer :initiative
      t.timestamps
    end
  end
end

class CreateMissiles < ActiveRecord::Migration
  def change
    create_table :missiles do |t|
      t.integer :dice
      t.integer :power
      t.timestamps
    end
  end
end

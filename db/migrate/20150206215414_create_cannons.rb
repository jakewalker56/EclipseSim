class CreateCannons < ActiveRecord::Migration
  def change
    create_table :cannons do |t|
      t.integer :dice
      t.integer :power
      t.timestamps
    end
  end
end

class AddIdsToTables < ActiveRecord::Migration
  def change
  	add_column :ships, :fleet_id, :integer
  	add_column :cannons, :ship_id, :integer
  	add_column :missiles, :ship_id, :integer
  	add_column :battles, :offense_id, :integer
  	add_column :battles, :defense_id, :integer
  end
end

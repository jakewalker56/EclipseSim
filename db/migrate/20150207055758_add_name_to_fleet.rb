class AddNameToFleet < ActiveRecord::Migration
  def change
  	add_column :fleets, :name, :string
  end
end

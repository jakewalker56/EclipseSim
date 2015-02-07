class AddIterationsToBattle < ActiveRecord::Migration
  def change
  	add_column :battles, :iterations, :integer
  end
end

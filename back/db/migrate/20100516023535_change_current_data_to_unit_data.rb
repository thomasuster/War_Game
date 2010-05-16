class ChangeCurrentDataToUnitData < ActiveRecord::Migration
   def self.up
	remove_column :games, :current_map
	add_column :games, :unit_data, :binary
  end

  def self.down
	remove_column :games, :turn_speed_minutes
	add_column :games, :unit_data, :binary
  end
end

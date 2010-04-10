class ChangeTurnSpeedToMinutes < ActiveRecord::Migration
  def self.up
	remove_column :games, :turn_speed
	add_column :games, :turn_speed_minutes, :integer
  end

  def self.down
	remove_column :games, :turn_speed_minutes
	add_column :games, :turn_speed, :time
  end
end

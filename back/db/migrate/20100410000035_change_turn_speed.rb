class ChangeTurnSpeed < ActiveRecord::Migration
  def self.up
	remove_column :games, :turn_speed
	add_column :games, :turn_speed, :time
  end

  def self.down
	remove_column :games, :turn_speed
	add_column :games, :turn_speed, :datetime
  end
end

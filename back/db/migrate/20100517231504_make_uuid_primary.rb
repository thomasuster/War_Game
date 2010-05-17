class MakeUuidPrimary < ActiveRecord::Migration
  def self.up
	remove_column :games, :uuid
	add_column :games, :uuid, :string, :primary => true
  end

  def self.down
	remove_column :games, :uuid
	add_column :games, :uuid, :string
  end
end

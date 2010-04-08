class ModifyUuid < ActiveRecord::Migration
  def self.up
	remove_column :users, :uuid
	add_column :users, :uuid, :string, :limit => 36, :primary => true
  end

  def self.down
	remove_column :users, :uuid
	add_column :users, :uuid, :string
  end
end

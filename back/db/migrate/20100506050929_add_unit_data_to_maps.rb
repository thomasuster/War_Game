class AddUnitDataToMaps < ActiveRecord::Migration
  def self.up
    add_column :maps, :unit_data, :binary
  end

  def self.down
    remove_column :maps, :unit_data
  end
end

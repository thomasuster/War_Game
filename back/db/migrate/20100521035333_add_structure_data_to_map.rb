class AddStructureDataToMap < ActiveRecord::Migration
	def self.up
		add_column :maps, :structure_data, :binary
	end

	def self.down
		remove_column :maps, :structure_data
	end
end

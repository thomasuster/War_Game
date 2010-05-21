class Map < ActiveRecord::Base
	include UUIDHelper
	
	def self.get_maps
		m = Map.find( :all, :select => 'uuid, name, players')
	end
	
	def self.get_map(uuid)
		m = Map.find( :first,  :conditions => { :uuid => uuid}, :select => 'name, players')
	end
	
	def self.get_data(uuid)
		m = Map.find( :first,  :conditions => { :uuid => uuid}, :select => 'data, structure_data')
	end
	
	def self.get_map_data(uuid)
		m = Map.find( :first,  :conditions => { :uuid => uuid}, :select => 'data, unit_data, structure_data')
	end
	
	def self.get_unit_data(uuid)
		m = Map.find( :first,  :conditions => { :uuid => uuid}, :select => 'unit_data')
	end
end

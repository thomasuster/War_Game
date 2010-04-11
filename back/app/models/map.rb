class Map < ActiveRecord::Base
	include UUIDHelper
	
	def get_maps
		m = Map.find( :all, :select => 'uuid, name, players')
	end
	
	def get_map(uuid)
		m = Map.find( :first,  :conditions => { :uuid => uuid}, :select => 'name, players')
	end
end

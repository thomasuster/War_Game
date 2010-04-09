class Map < ActiveRecord::Base
	include UUIDHelper
	
	def get_maps
		m = Map.find( :all, :select => 'uuid, name, players')
	end
end

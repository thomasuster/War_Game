require 'Board_object'
require 'Stats'

class Sector < Board_object
	attr_accessor :sector_name
	STATS_XML = "../../public/front/stats/sectors.xml"
	
	def initialize(sector_name, location)
		super(location)
		@sector_name = sector_name
		
		#Static Stats
		if defined?(@@stats) == nil
			@@stats = Stats.new(STATS_XML).hash
		end
	end
	
	def get_name() 
		return sector_name;
	end
		
	def get_infantry_moves() 
		return @@stats[sector_name]["infantry_moves"]
	end

	def get_vehicle_moves() 
		return @@stats[sector_name]["vehicle_moves"]
	end

	def get_attacking() 
		return @@stats[sector_name]["attacking"]
	end

	def get_defending() 
		return @@stats[sector_name]["defending"]
	end

	def to_s() 
		return sector_name;
	end
end
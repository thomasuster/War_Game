require 'War_game/Board_object'
require 'War_game/Stats'

module War_game
	class Sector < Board_object
		
		attr_accessor :sector_name
		STATS_XML = "C:/Users/thomasuster/War_game/back/public/front/stats/sectors.xml"
		
		def initialize(sector_name, location)
			super(location)
			@sector_name = sector_name
			
			#Static Stats
			if defined?(@@stats) == nil
				@@stats = Stats.new(STATS_XML).hash
			end
		end
		
		def get_name() 
			return @sector_name;
		end
			
		def get_infantry_moves() 
			return @@stats[@sector_name]["infantry_moves"].to_i
		end

		def get_vehicle_moves() 
			return @@stats[@sector_name]["vehicle_moves"].to_i
		end

		def get_attacking() 
			return @@stats[@sector_name]["attacking"].to_i
		end

		def get_defending() 
			return @@stats[@sector_name]["defending"].to_i
		end

		def to_s() 
			return @sector_name;
		end
	end
end
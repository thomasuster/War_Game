require 'War_game/Stats'

module War_game
	class Weapon
		attr_accessor :weapon_name
		STATS_XML = "C:/Users/thomasuster/War_game/back/public/front/stats/weapons.xml"
		
		def initialize(weapon_name)
			@weapon_name = weapon_name
			
			#Static Stats
			if defined?(@@stats) == nil
				@@stats = Stats.new(STATS_XML).hash
			end
		end
		
		def get_name() return @@stats[@unit_name]["name"] end
		
		def get_type() return @@stats[@unit_name]["type"] end
		
		def get_power() return @@stats[@unit_name]["power"].to_i end
		
		def get_number() return @@stats[@unit_name]["number"].to_i end
		
		def to_s() 
			return @weapon_name;
		end
	end
end
require 'Board_object'
require 'Stats'

class Unit < Board_object
	attr_accessor :color
	attr_accessor :number
	attr_accessor :unit_name
	STATS_XML = "../../public/front/stats/units.xml"
	
	def initialize(unit_name, color, location)
		super(location)
		@unit_name = unit_name
		@color = color
		
		#Static Stats
		if defined?(@@stats) == nil
			@@stats = Stats.new(STATS_XML).hash
		end
		
		#Dynamic Stats
		@number = @@stats[unit_name]["number"];
	end
	
	def get_name() return @unit_name end
	
	def get_number() return @number end
	
	def get_type() return @@stats[@unit_name]["type"] end
	
	def get_tier() return @@stats[@unit_name]["tier"] end
	
	def get_weapon() return @@stats[@unit_name]["weapon"] end
	
	def get_range() return @@stats[@unit_name]["range"] end
	
	def get_optimum_range() return @@stats[@unit_name]["optimum_range"] end
	
	def get_bullet_defense() return @@stats[@unit_name]["bullet_defense"] end
	
	def get_shell_defense() return @@stats[@unit_name]["shell_defense"] end
	
	def get_moves() return @@stats[@unit_name]["moves"] end
	
	def to_s() 
		return @unit_name;
	end
end
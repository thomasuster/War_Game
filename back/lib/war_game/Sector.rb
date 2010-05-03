class Sector < Board_object
	attr_accessor :sector_name
	
	def initialize(sector_name, location)
		super(location)
		@sector_name = sector_name
		
		#Static Stats
		if (stats == nil)
			stats = new Stats(stats_xml);
			sector_stats = stats.hash;
		end
	end
	
	def get_name() { return sector_name; }
			
	def get_infantry_moves() { return sector_stats[sector_name]["infantry_moves"]; }
		
	def get_vehicle_moves() { return int(sector_stats[sector_name]["vehicle_moves"]); }
		
	def get_attacking() { return int(sector_stats[sector_name]["attacking"]); }
		
	def get_defending() { return int(sector_stats[sector_name]["defending"]); }
		
	def to_s() { return sector_name; }
end
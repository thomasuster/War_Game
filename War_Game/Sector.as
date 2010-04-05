package War_game
{
	import War_game.Board_object;
	import War_game.Stats;
	import flash.display.BitmapData;
	
	public class Sector extends Board_object
	{
		//Static Stats
		[Embed(source = "/stats/sectors.xml", mimeType="application/octet-stream")]
		private static const stats_xml:Class;
		public static var stats:Stats;
		public static var sector_stats:Object;
		
		private var sector_name:String;
		
		public function Sector(new_bitmapData:BitmapData = null, new_location:Location=null, _sector_name:String="empty"):void
		{
			super(new_bitmapData, new_location);
			sector_name = _sector_name;
			
			//Static Stats
			if (stats == null)
			{
				stats = new Stats(stats_xml);
				sector_stats = stats.hash;
			}
		}

		public function get_name():String { return sector_name; }
			
		public function get_infantry_moves():String { return sector_stats[name]["infantry_moves"]; }
			
		public function get_vehicle_moves():int { return int(sector_stats[name]["vehicle_moves"]); }
			
		public function get_attacking():int { return int(sector_stats[name]["attacking"]); }
			
		public function get_defending():int { return int(sector_stats[name]["defending"]); }
			
		public override function toString():String { return sector_name; }
	}
}
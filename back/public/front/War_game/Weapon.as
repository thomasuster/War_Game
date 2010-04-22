package War_game
{
	import War_game.Stats;
	
	public class Weapon
	{
		//Static Stats
		[Embed(source = "/stats/weapons.xml", mimeType="application/octet-stream")]
		private static const stats_xml:Class;
		public static var stats:Stats;
		public static var weapon_stats:Object;
		public var weapon_name:String;
		
		public function Weapon(_weapon_name:String="Carbine"):void
		{
			weapon_name = _weapon_name;
			
			//Static Stats
			if (stats == null)
			{
				stats = new Stats(stats_xml);
				weapon_stats = stats.hash;
			}
		}
		
		public function get_name():String
			{ return weapon_stats[weapon_name]["name"];}
		public function get_type():String
			{ return weapon_stats[weapon_name]["type"];}
		public function get_power():int
			{ return int(weapon_stats[weapon_name]["power"]);}
		public function get_number():int
			{ return int(weapon_stats[weapon_name]["number"]);}
			
		public function toString():String
		{
			return "Weapon";
		}
	}
}
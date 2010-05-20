package War_game
{	
	import flash.display.BitmapData;
	import War_game.Colored;
	import War_game.Stats;
	
	public class Structure extends Colored
	{
		//Static Stats, Maybe later
		/*[Embed(source = "/stats/units.xml", mimeType="application/octet-stream")]
		private static const stats_xml:Class;
		public static var stats:Stats;
		public static var unit_stats:Object;*/
		
		public var structure_name:String;
		
		public function Structure(_structure_name:String="empty", _color:String="red", new_bitmapData:BitmapData = null, new_location:Location=null):void
		{
			super(_color, new_bitmapData, new_location);
			structure_name = _structure_name;
			
			/* Maybe later
			//Static Stats
			if (stats == null)
			{
				stats = new Stats(stats_xml);
				unit_stats = stats.hash;
			}*/
		}
		
		public function get_name():String { return structure_name; }
		
		public override function toString():String
		{
			return structure_name;
		}
	}
}
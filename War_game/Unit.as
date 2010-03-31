package War_game
{
	import flash.utils.Dictionary;
	import War_game.Board_object;
	import War_game.Stats;
	import flash.display.BitmapData;
	
	public class Unit extends Board_object
	{
		//Static Stats
		[Embed(source = "/stats/units.xml", mimeType="application/octet-stream")]
		private static const stats_xml:Class;
		public static var stats:Stats;
		public static var unit_stats:Object;
		public var unit_name:String;
		
		public function Unit(_unit_name:String="empty", new_bitmapData:BitmapData = null, new_location:Location=null):void
		{
			super(new_bitmapData, new_location);
			unit_name = _unit_name;
			//trace("unit_name = " + unit_name);
			
			//Static Stats
			if (stats == null)
			{
				stats = new Stats(stats_xml);
				unit_stats = stats.hash;
			}
		}
		
		public override function toString():String
		{
			return "Unit";
		}
	}
}
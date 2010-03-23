package War_game
{
	import flash.utils.Dictionary;
	import War_game.Board_object;
	import flash.display.BitmapData;
	
	public class Unit extends Board_object
	{
		[Embed(source = "/stats/units.xml", mimeType="application/octet-stream")]
		private static const unit_stats:Class;
	
		public static var stats:Object;
		
		//private var number:int;
		public function Unit(new_bitmapData:BitmapData = null, new_location:Location=null):void
		{
			super(new_bitmapData, new_location);
			
			trace(stats);
			if (stats == null)
			{
				stats = new Object();
				var x:XML = XML(new unit_stats());
				process_xml(x);
			}
		}
		
		private static function process_xml(xml:XML):void 
		{
			for each (var unit:XML in xml.*)
			{
				for each(var a:XML in unit.@*)
				{
					stats[String(a.name())] = String(a.toXMLString());
					trace (a.name() + " : " + a.toXMLString());
				}
				
			}
		}
		
		public override function toString():String
		{
			return "Unit";
		}
	}
}
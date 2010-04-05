package War_game
{
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import War_game.Board_object;
	import War_game.Stats;
	import flash.display.BitmapData;
	import flash.text.TextFormat;
	
	public class Unit extends Board_object
	{
		//Static Stats
		[Embed(source = "/stats/units.xml", mimeType="application/octet-stream")]
		private static const stats_xml:Class;
		public static var stats:Stats;
		public static var unit_stats:Object;
		public var unit_name:String;
		
		private var number_label:TextField;
		private var number:int;
		public var range:int;
		
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
			
			//stats
			range = int(unit_stats[unit_name]["range"]);
			number = int(unit_stats[unit_name]["number"]);
			
			//Text
			number_label = new TextField();
			number_label.text = String(number);
			number_label.selectable = false;
			number_label.background = true;
			number_label.backgroundColor = 0xFFFFFF;
			number_label.border = true;
			number_label.width = 16;
			number_label.height = 16;
			
			//Format
			var format:TextFormat = new TextFormat();
            format.font = "Verdana";
            format.color = 0x000000;
            format.size = 10;
            number_label.defaultTextFormat = format;
			
			this.addChild(number_label);
		}
		
		public function refresh_number():void
		{
			number_label.text = String(number);
		}
		
		public override function toString():String
		{
			return "Unit";
		}
	}
}
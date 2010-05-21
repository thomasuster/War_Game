package War_game
{
	import flash.display.BitmapData;
	import War_game.Colored;
	import War_game.Stats;
	
	import flash.text.TextField;
	import flash.text.TextFormat;

	
	public class Unit extends Colored
	{
		//Static Stats
		[Embed(source = "/stats/units.xml", mimeType="application/octet-stream")]
		private static const stats_xml:Class;
		public static var stats:Stats;
		public static var unit_stats:Object;
		public var unit_name:String;
		
		//Number
		private var number_label:TextField;
		public var number:int;
		
		public function Unit(_unit_name:String="empty", _color:String="red", _number:int=-1, new_bitmapData:BitmapData = null, new_location:Location=null):void
		{
			super(_color, new_bitmapData, new_location);
			unit_name = _unit_name;
			
			//trace("unit_name = " + unit_name);
			
			//Static Stats
			if (stats == null)
			{
				stats = new Stats(stats_xml);
				unit_stats = stats.hash;
			}
			
			//Dynamic Stats
			if(_number == -1)
				number = int(unit_stats[unit_name]["number"]);
			else 
			{
				number = _number;
			}
			
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
		
		
		public function get_number():int { return number; }
		
		
		public function get_name():String { return unit_name; }
			
		public function get_type():String { return unit_stats[unit_name]["type"]; }
		
		public function get_tier():int { return unit_stats[unit_name]["tier"]; }
		
		public function get_weapon():String { return unit_stats[unit_name]["weapon"]; }
		
		public function get_range():int { return unit_stats[unit_name]["range"]; }
		
		public function get_optimum_range():int { return unit_stats[unit_name]["optimum_range"]; }
		
		public function get_bullet_defense():int { return unit_stats[unit_name]["bullet_defense"]; }
		
		public function get_shell_defense():int { return unit_stats[unit_name]["shell_defense"]; }
		
		public function get_moves():int { return unit_stats[unit_name]["moves"]; }
		
		public override function toString():String
		{
			return "Unit";
		}
	}
}
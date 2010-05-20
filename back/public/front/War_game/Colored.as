package War_game
{	
	import War_game.Board_object;
	
	public class Colored extends Board_object
	{
		//Color
		private var color:String;
		private static var colors:Object;
		
		public function Unit(_color:String="red", new_bitmapData:BitmapData = null, new_location:Location=null):void
		{
			super(new_bitmapData, new_location);
			color = _color;
			
			//Colors
			if (colors == null)
			{
				colors = new Object();
				colors["red"] = 0xFF0000;
				colors["purple"] = 0x9D00E4;
				colors["orange"] = 0xFF7700;
				colors["yellow"] = 0xFFFF00;
				colors["green"] = 0x00FF00;
				colors["teal"] = 0x00FFFF;
				colors["blue"] = 0x0000FF;
				colors["pink"] = 0xFF00FF;
			}
			
			var matrix:Array = new Array();
			var red:Number = Conversion.rgb_color(colors[color], "red")/255.0;
			var green:Number = Conversion.rgb_color(colors[color], "green")/255.0;
			var blue:Number = Conversion.rgb_color(colors[color], "blue")/255.0;
            matrix = matrix.concat([red, 0, 0, 0, 0]); // red
            matrix = matrix.concat([0, green, 0, 0, 0]); // green
            matrix = matrix.concat([0, 0, blue, 0, 0]); // blue
            matrix = matrix.concat([0, 0, 0, 1, 0]); // alpha
			var filter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			var filters:Array = new Array();
            filters.push(filter);
            bitmap.filters = filters;
		}
		
		public function get_color():String { return color; }
		
		public override function toString():String
		{
			return color;
		}
	}
}
package War_game
{
	import War_game.Board_object;
	import flash.display.BitmapData;
	
	public class Sector extends Board_object
	{
		public var type:String;
		
		public function Sector(new_bitmapData:BitmapData = null, new_location:Location=null, new_type:String="empty"):void
		{
			super(new_bitmapData, new_location);
			type = new_type;
		}

		public override function toString():String
		{
			return type;
		}
	}
}
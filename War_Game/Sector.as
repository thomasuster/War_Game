package War_game
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.ui.KeyLocation;
	import mx.controls.Image; 
	import War_game.Location;
	
	public class Sector extends Bitmap
	{
		public var type:String;
		public var location:Location;
		
		public function Sector(new_bitmapData:BitmapData = null,new_type:String="empty", new_location:Location=null):void
		{
			bitmapData = new_bitmapData;
			type = new_type;
			location = new_location;
		}
		
		public override function toString():String
		{
			return type;
		}
	}
}
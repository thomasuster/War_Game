package War_game
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.ui.KeyLocation;
	import mx.controls.Image; 
	import War_game.Location;
	
	public class Sector extends Sprite
	{
		private var bitmap:Bitmap;
		public var type:String;
		public var location:Location;
		
		public function Sector(new_bitmapData:BitmapData = null,new_type:String="empty", new_location:Location=null):void
		{
			bitmap = new Bitmap(new_bitmapData);
			type = new_type;
			location = new_location;
			this.addChild(bitmap);
		}
		
		public function image(new_bitmapData:BitmapData):void
		{
			bitmap.bitmapData = new_bitmapData;
			//trace("Changed");
			//this.removeChild(bitmap);
			//bitmap = new Bitmap(new_bitmapData);
			//this.addChild(bitmap);
			//bitmap.bitmapData = new_bitmapData;
		}
		public override function toString():String
		{
			return type;
		}
	}
}
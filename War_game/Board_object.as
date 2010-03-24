package War_game
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import War_game.Location;
	
	public class Board_object extends Sprite
	{
		protected var bitmap:Bitmap;
		public var location:Location;
		
		public function Board_object(new_bitmapData:BitmapData = null, new_location:Location=null):void
		{
			bitmap = new Bitmap(new_bitmapData);
			location = new_location;
			this.addChild(bitmap);
			
			set_location(new_location);
		}
		
		public function set_location(new_location:Location):void 
		{
			location = new_location;
			var x:int = new_location.x;
			var y:int = new_location.y;
			//Position
			if (y % 2 == 0)
				this.x = x * this.width;
			else
				this.x = x * this.width + this.width/2;
			this.y = y / 2 * this.height * 3 / 2;
		}
		
		public function image(new_bitmapData:BitmapData):void
		{
			bitmap.bitmapData = new_bitmapData;
		}
	}
}
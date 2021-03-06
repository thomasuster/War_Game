package War_game
{
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import War_game.Location;
	
	/**
	* Base class for board objects like units and sectors
	*/
	public class Board_object extends Sprite
	{
		protected var bitmap:Bitmap;
		public var location:Location;
		public static const sector_width:int = 34;
		public static const sector_height:int = 40;
		
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
			var index_x:int = new_location.x;
			var index_y:int = new_location.y;
			//Position
			if (index_y % 2 == 0)
				this.x = index_x * sector_width;
			else
				this.x = index_x * sector_width + sector_width/2;
			this.y = index_y / 2 * sector_height * 3 / 2;
		}
		
		public function image(new_bitmapData:BitmapData):void
		{
			bitmap.bitmapData = new_bitmapData;
		}
	}
}
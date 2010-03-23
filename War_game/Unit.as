package War_game
{
	import War_game.Board_object;
	import flash.display.BitmapData;
	
	public class Unit extends Board_object
	{
		[Bindable]
		private var number:int;
		public function Unit(new_bitmapData:BitmapData = null, new_location:Location=null):void
		{
			super(new_bitmapData, new_location);
		}
		
		public override function toString():String
		{
			return "Unit";
		}
	}
}
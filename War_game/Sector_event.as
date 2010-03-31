package War_game
{
	import flash.events.Event;
	import War_game.Sector;
	
	public class Sector_event extends Event
	{
		public static const CLICKED:String = "clicked";
		public var sector:Sector;
		
		public function Sector_event(_sector:Sector, type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
			sector = _sector;
        }
	}
}
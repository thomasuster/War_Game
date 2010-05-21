package War_game
{
	import flash.events.Event;
	import War_game.Location;
	
	public class Location_event extends Event
	{
		public static const CLICKED:String = "clicked";
		public var location:Location;
		
		public function Location_event(_location:Location, type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
			location = _location;
        }
	}
}
package War_game
{
	import flash.events.Event;
	import War_game.Unit;
	
	public class Unit_event extends Event
	{
		public static const CLICKED:String = "clicked";
		public var unit:Unit;
		
		public function Unit_event(_unit:Unit, type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
			unit = _unit;
        }
	}
}
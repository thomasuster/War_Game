package Standard
{
	import flash.events.Event;
	
	public class Module_event extends Event
	{
		public static const COMPLETE:String = "complete";
		
		public function Module_event(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
        {
            super(type, bubbles, cancelable);
        }
	}
}
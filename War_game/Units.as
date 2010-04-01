package War_game
{
	import Math;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.net.URLRequestHeader;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	import flash.display.Loader;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import War_game.Unit_event;
	
	import Standard.Image_resource;
	
	import War_game.Location;
	
	public class Units extends Sprite
	{	
		private var units:Object;
		private var image_resource:Image_resource;
		
		public function Units(_image_resource:Image_resource):void
		{
			image_resource = _image_resource;
			units = new Object();
		}
		
		public function make_unit(location:Location, type:String):void
		{
			//Add units
			var unit:Unit = new Unit(type, image_resource.duplicate_image(type),location);
			units[location] = unit;
			this.addChild(unit);
			
			//Unit moving
			unit.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, move);
			function move(event:MouseEvent):void
			{
				dispatchEvent(new Unit_event(Unit(event.target), Unit_event.CLICKED, false, false));
			}
		}
		
		public function move_unit(unit:Unit, location:Location):void
		{
			units[location] = unit;
			delete units[unit.location];
			unit.set_location(location);
		}
		
	}
}
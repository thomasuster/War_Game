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
	
	import mx.controls.Alert;
	
	public class Units extends Sprite
	{	
		private var units:Object;
		private var image_resource:Image_resource;
		
		private var moves_xml:XML;
		
		public function Units(_image_resource:Image_resource):void
		{
			//Init xml
			moves_xml = new XML("<moves></moves>");
			
			image_resource = _image_resource;
			units = new Object();
		}
		
		public function reset():void
		{
			moves_xml = new XML("<moves></moves>");
			
			for each(var unit:Unit in units)
				destroy_unit(unit.location);
		}
		
		/**
		* Loads the map from given xml
		*/
		public function load_units(xml:XML):void 
		{
			for each (var unit_data:XML in xml.unit)
			{
				var x:int = Number(unit_data.@x);
				var y:int = Number(unit_data.@y);
				var color:String = String(unit_data.@color);
				var type:String = String(unit_data);
				var l:Location = new Location(x, y);
				make_unit(l, type, color);
			}
		}	
		
		/**
		* Returns XML of the all current units
		*/
		public function export_units():XML 
		{
			var s:String = "<units>\n";
			
			for each(var unit:Unit in units)
				s += "\t<unit x='" + unit.location.x + "' y='" + unit.location.y + "' number='" + unit.get_number() + "' color='" + unit.get_color() + "'>" + unit.get_name() + "</unit>\n";
						
			s += "</units>\n";
			var xml:XML = new XML(s);
			return xml;
		}
		
		public function make_unit(location:Location, type:String, color:String):void
		{
			//Add units
			var unit:Unit = new Unit(type, color, image_resource.duplicate_image(type), location);
			//trace("START");
			units[location] = unit;
			//trace("END");
			this.addChild(unit);
			
			//Unit moving
			unit.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, move);
			function move(event:MouseEvent):void
			{
				dispatchEvent(new Unit_event(Unit(event.currentTarget), Unit_event.CLICKED, false, false));
			}
		}
		
		public function move_unit(unit:Unit, location:Location):void
		{
			var start:String = "<start x=\"" + unit.location.x + "\" y=\"" + unit.location.y + "\"></start>";
			var end:String = "<end x=\"" + location.x + "\" y=\"" + location.y + "\"></end>";
			moves_xml.appendChild(new XML("<move>"+start+end+"</move>"));
			
			//Alert.show(moves_xml);
			trace(location.x + " | " + location.y);
			units[location] = unit;
			delete units[unit.location];
			unit.set_location(location);
		}
		
		public function destroy_unit(location:Location):void
		{
			this.removeChild(units[location]);
			delete units[location];
		}
		public function get_unit(location:Location):Unit
		{
			return units[location];
		}
		
		public function get_moves():XML { return moves_xml; }
		
		/*
		public function in_range(unit:Unit, target:Unit):Sprite
		{
			var myShape:Sprite = new Sprite();
			myShape.graphics.lineStyle(2, 0x990000, .75);
			myShape.graphics.moveTo(unit.x + Board_object.sector_width/2, unit.y + Board_object.sector_height/2);
			myShape.graphics.lineTo(target.x + Board_object.sector_width/2, target.y + Board_object.sector_height/2);
			trace("Drew a line from " + unit.x + " " + unit.y + " to " + target.x + " " + target.y);
			return myShape;
		}*/
		
		
	}
}
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
	
	import Standard.Image_resource;
	
	import War_game.Location;
	import War_game.Location_event;
	
	import mx.controls.Alert;
	
	public class Structures extends Sprite
	{	
		private var structures:Object;
		private var image_resource:Image_resource;
		
		private var moves_xml:XML;
		
		public function Structures(_image_resource:Image_resource):void
		{
			//Init xml
			moves_xml = new XML("<moves></moves>");
			
			image_resource = _image_resource;
			structures = new Object();
		}
		
		public function reset():void
		{
			moves_xml = new XML("<moves></moves>");
			
			//for each(var structure:Structure in structures)
				//destroy_structure(structure.location);
		}
		
		/**
		* Loads the map from given xml
		*/
		public function load_structures(xml:XML):void 
		{
			for each (var structure_data:XML in xml.structure)
			{
				var x:int = Number(structure_data.@x);
				var y:int = Number(structure_data.@y);
				var color:String = String(structure_data.@color);
				var number:int = int(structure_data.@number);
				var type:String = String(structure_data);
				var l:Location = new Location(x, y);
				make_structure(l, type, color);
			}
		}	
		
		/**
		* Returns XML of the all current structures
		*/
		public function export_structures():XML 
		{
			var s:String = "<structures>\n";
			
			for each(var structure:Structure in structures)
				s += "\t<structure x='" + structure.location.x + "' y='" + structure.location.y + "' color='" + structure.get_color() + "'>" + structure.get_name() + "</structure>\n";
						
			s += "</structures>\n";
			var xml:XML = new XML(s);
			return xml;
		}
		
		public function make_structure(location:Location, type:String, color:String):void
		{
					//Alert.show("Making a " + type);
			//Add structures
			var structure:Structure = new Structure(type, color, image_resource.duplicate_image(type), location);
			//trace("START");
			structures[location] = structure;
			//trace("END");
			this.addChild(structure);
			
			//Structure selection
			structure.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, move);
			function move(event:MouseEvent):void
			{
				dispatchEvent(new Location_event(location, Location_event.CLICKED));
			}
		}
		
		/*public function build_unit(structure:Structure, location:Location):void
		{
			var start:String = "<start x=\"" + structure.location.x + "\" y=\"" + structure.location.y + "\"></start>";
			var end:String = "<end x=\"" + location.x + "\" y=\"" + location.y + "\"></end>";
			moves_xml.appendChild(new XML("<move>"+start+end+"</move>"));
			
			//Alert.show(moves_xml);
			trace(location.x + " | " + location.y);
			structures[location] = structure;
			delete structures[structure.location];
			structure.set_location(location);
		}*/

		/*
		public function move_structure(structure:Structure, location:Location):void
		{
			var start:String = "<start x=\"" + structure.location.x + "\" y=\"" + structure.location.y + "\"></start>";
			var end:String = "<end x=\"" + location.x + "\" y=\"" + location.y + "\"></end>";
			moves_xml.appendChild(new XML("<move>"+start+end+"</move>"));
			
			//Alert.show(moves_xml);
			trace(location.x + " | " + location.y);
			structures[location] = structure;
			delete structures[structure.location];
			structure.set_location(location);
		}*/
		
		public function destroy_structure(location:Location):void
		{
			this.removeChild(structures[location]);
			delete structures[location];
		}
		public function get_structure(location:Location):Structure
		{
			return structures[location];
		}
		
		public function get_moves():XML { return moves_xml; }
	}
}
package War_game
{
	import adobe.utils.XMLUI;
	import flash.display.DisplayObject;
	import flash.filters.ConvolutionFilter;
	import flash.ui.KeyLocation;
	import mx.core.UIComponent;
	import War_game.Board_object;
	import War_game.Screens;
	import War_game.Sector;
	import War_game.Location;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.events.MouseEvent;
	import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
	import Standard.Image_resource;

	public class Board extends UIComponent
	{
		//Zone
		private const sizeX:int = 23;
		private const sizeY:int = 20;
		
		public var mode:String;
		public var tool:String;
		
		private var active_unit:Unit;
		private var screens:Screens;
		private var map:Dictionary;
		private var units:Dictionary;
		private var image_resource:Image_resource;
		
		public function Board()
		{
			map = new Dictionary();
			screens = new Screens(sizeX, sizeY);
			units = new Dictionary();
			image_resource = new Image_resource("images.xml");
			active_unit = null;
			opaqueBackground = "0xFFFFFF";
			tool = "grass";
			
			
			image_resource.addEventListener("loaded", completeHandler);
			
			
			function completeHandler(event:Event):void
			{
				//The map
				//load_xml("maps/test.xml");
				load_xml("maps/river.xml");
			}	
		}
		
		public function map_toString():String
		{
			var s:String = "";
			var total:int = 0;
			for (var key:Object in map) {
				if(map[key].toString() != "empty")
				{
						s += "{" + key.toString() + " " + map[key].toString() + "}\n";
						total++;
				}
			}
			return s + "\nTotal: " + total + "\n";
		}
		
		
		
		public function load_xml(xml_url:String):void 
		{
			var myXML:XML = new XML();
			var myXMLURL:URLRequest = new URLRequest(xml_url);
			var myLoader:URLLoader = new URLLoader(myXMLURL);
			myLoader.addEventListener("complete", xmlLoaded);
			function xmlLoaded(event:Event):void
			{
				myXML = XML(myLoader.data);
				trace("Data loaded.");
				load_map(myXML); //Decouple me
			}
		}
		
		public function load_map(xml:XML):void 
		{
			var original_map:Object = new Object();
			for each (var sector_data:XML in xml.s)
			{
				var x:int = Number(sector_data.@x);
				var y:int = Number(sector_data.@y);
				var type:String = String(sector_data);
				original_map[x + " " +y] = type;
			}
			
			//Empty Spots
			for (var indexX:int = 0; indexX < sizeX; indexX++)
			{
				for (var indexY:int = 0; indexY < sizeY; indexY++)
				{
					//init
					var location:Location = new Location(indexX, indexY);
					
					if(original_map[indexX + " " + indexY] == null)
						make_sector(location, "empty");
					else
						make_sector(location, original_map[indexX + " " + indexY]);
						
					//screen
					screens.insert(image_resource.duplicate_image("screen"),location);
				}
			}
			this.addChild(screens);
		}
		
		public function export_map():XML 
		{
			var s:String = "<map>\n";
			for (var key:Object in map) {
				if(map[key].type != "empty")
				   s += "\t<s x='" + key.x + "' y='" + key.y + "'>" + map[key].type + "</s>\n";
			}
			s += "</map>\n";
			var x:XML = new XML(s);
			return x;
		}
		
		private function make_unit(location:Location, type:String):void
		{
			var unit:Unit = new Unit(image_resource.duplicate_image(type),location);
			units[location] = unit;
			this.addChild(unit);
			trace("Added a " + type);
			
			//Unit moving
			unit.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, move);
			function move(event:MouseEvent):void
			{
				mode = "move_unit"
				active_unit = unit;
				screens.visible = true;
				//int(Unit.stats["range"])
				screens.reveal_circle(location, 1);
			}
		}
		
		private function move_unit(location:Location):void
		{
			//delete units[active_unit.location];
			active_unit.set_location(location);
			//units[active_unit.location] = active_unit;
		}
		
		private function make_sector(location:Location, type:String):void
		{
			//Init
			var sector:Sector = new Sector(image_resource.duplicate_image(type), location,type);
			map[location] = sector;
			
			//Map editing
			sector.addEventListener(flash.events.MouseEvent.MOUSE_OVER	, change_sector);
			sector.addEventListener(flash.events.MouseEvent.MOUSE_DOWN	, change_sector);
			function change_sector(event:MouseEvent):void
			{
				if (!event.buttonDown)
					return;
					
				var x:int = event.currentTarget.location.x;
				var y:int = event.currentTarget.location.y;
					
				switch (mode)
				{
					case "sector":
						if (tool != "empty")
						{
							if (map[event.currentTarget.location] != null)
							{
								map[event.currentTarget.location].type = tool;
								map[event.currentTarget.location].image(image_resource.duplicate_image(tool));
							}
							else
								trace("Not found at " + x + " " + y);
						}
						break;
					case "unit":
						make_unit(event.currentTarget.location, tool);
						break;
					case "move_unit":
						trace("Called" + x + " " + y);
						//screens.visible = true;
						move_unit(event.currentTarget.location);
						break;
				}
			}
			
			this.addChild(sector);
			
			
			
		}		
	}
}
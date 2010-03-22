package War_game
{
	import flash.display.DisplayObject;
	import flash.filters.ConvolutionFilter;
	import flash.ui.KeyLocation;
	import mx.core.UIComponent;
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
		
		private var map:Dictionary;
		private var units:Dictionary;
		private var image_resource:Image_resource;
		
		public function Board()
		{
			map = new Dictionary();
			units = new Dictionary();
			image_resource = new Image_resource("images.xml");
			opaqueBackground = "0xFFFFFF";
			tool = "grass";
			
			
			image_resource.addEventListener("loaded", completeHandler);
			
			
			function completeHandler(event:Event):void
			{
				if(image_resource.has_image("empty"))
				{
					//Empty Spots
					for (var indexX:int = 0; indexX < sizeX; indexX++)
					{
						for (var indexY:int = 0; indexY < sizeY; indexY++)
						{
							make_sector(indexX, indexY, "empty");
						}
					}
				}
				
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
			for each (var sector_data:XML in xml.s)
			{
				var x:int = Number(sector_data.@x);
				var y:int = Number(sector_data.@y);
				var type:String = String(sector_data);
				//trace(x + " " + y + " " + type);
				
				make_sector(x, y, type);
			}
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
		
		/*private function make_init(x:int, y:int, type:String):Object
		{
			
			var hash:Object = new Object();
			//Init
			hash["location"] = new Location(x, y);
			 
			
			//Position
			if (y % 2 == 0)
				hash["x"] = x * 34;
			else
				hash["x"] = x * 34 + 34/2;
			hash["y"] = y / 2 * 40 * 3 / 2;
			return hash;
			
		}*/
		private function make_unit(x:int, y:int, type:String):void
		{
			var location:Location = new Location(x, y);
			var unit:Unit = new Unit(image_resource.duplicate_image(type),location);
			units[location] = unit;
			this.addChild(unit);
			trace("Added a " + type);
		}
		
		private function make_sector(x:int, y:int, type:String):void
		{
			//Init
			var location:Location = new Location(x, y);
			var sector:Sector = new Sector(image_resource.duplicate_image(type), location,type);
			map[location] = sector;
			
			//Position
			/*
			if (y % 2 == 0)
				sector.x = x * sector.width;
			else
				sector.x = x * sector.width + sector.width/2;
			sector.y = y / 2 * sector.height * 3 / 2;*/
			
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
						make_unit(x, y, tool);
						break;
				}
			}
			
			this.addChild(sector);
			
			
			
		}		
	}
}
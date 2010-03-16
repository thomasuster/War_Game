package War_game
{
	import flash.ui.KeyLocation;
	import mx.containers.Canvas;
	import War_game.Sector;
	import War_game.Location;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.events.MouseEvent;

	public class Board extends Canvas
	{
		//Zone
		private const sizeX:int = 10;
		private const sizeY:int = 10;
		public var map_tool:String;
		private var map:Dictionary = new Dictionary();
		
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
		
		public function Board()
		{
			opaqueBackground = "0xFFFFFF";
			map_tool = "grass";
			
			
			
			//The map
			//load_xml("maps/test.xml");
			load_xml("maps/pleasanton.xml");
			
			//Empty Spots
			for (var indexX:int = 0; indexX < sizeX; indexX++)
			{
				for (var indexY:int = 0; indexY < sizeY; indexY++)
				{
					make_sector(indexX, indexY, "empty");
				}
			}
			
			
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
		
		private function make_sector(x:int, y:int, type:String):void
		{
			//if (map[new Location(x, y)])
				//return;
			
			var location:Location = new Location(x, y);
			var sector:Sector = new Sector(type, location);
			map[location] = sector;
			
			sector.addEventListener(flash.events.Event.COMPLETE, function():void {
				if (y % 2 == 0)
					sector.x = x * sector.contentWidth;
				else
					sector.x = x * sector.contentWidth + sector.contentWidth/2;
				
				sector.y = y / 2 * sector.contentHeight * 3 / 2;
				//trace(x + " " + y);
				addChild(sector);
			});
			
			sector.addEventListener(flash.events.MouseEvent.MOUSE_OVER	, draw_sector);
			sector.addEventListener(flash.events.MouseEvent.MOUSE_DOWN	, draw_sector);
			function draw_sector(event:MouseEvent):void
			{
				if (event.buttonDown)
				{
					var x:int = event.currentTarget.location.x;
					var y:int = event.currentTarget.location.y;
					
					if (map_tool != "empty")
					{
						if (map[event.currentTarget.location] != null)
						{
							trace("found");
							
							//if (map[event.currentTarget.location].type == map_tool)
								//return;
							trace(map_toString())
							map[event.currentTarget.location] = null;
							delete map[event.currentTarget.location];
							trace(map_toString())
						}
						else
							trace("Not found at " + x + " " + y);
							
						make_sector(x, y, map_tool);
					}
				}
			}
			
			sector.load("images/" + type +".png");
		}		
	}
}
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
		

		public function Board()
		{
			opaqueBackground = "0xFFFFFF";
			map_tool = "grass";
			
			map.toString = function():String {
				var s:String = "";
				for (var key:Object in this) {
				   s += "{" + key.toString() + map[key].toString() + "}\n";
				}
				return s;
			}
			
			//The map
			load_xml("maps/test.xml");
			
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
		
		private function make_sector(x:int, y:int, type:String):void
		{
			//if (map[new Location(x, y)])
				//return;
			
			var location:Location = new Location(x, y);
			var sector:Sector = new Sector(type, location);
			map[String(location)] = sector;
			
			sector.addEventListener(flash.events.Event.COMPLETE, function():void {
				if (y % 2 == 0)
					sector.x = x * sector.contentWidth;
				else
					sector.x = x * sector.contentWidth + sector.contentWidth/2;
				
				sector.y = y / 2 * sector.contentHeight * 3 / 2;
				//trace(x + " " + y);
				addChild(sector);
			});
			
			sector.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, mouse_move);
			function mouse_move(event:MouseEvent):void
			{
				if (event.buttonDown)
				{
					var x:int = event.currentTarget.location.x;
					var y:int = event.currentTarget.location.y;
					
					if (map_tool != "empty")
					{
						if (map[String(new Location(x, y))] != null)
						{
							trace("found");
							delete map[String(new Location(x, y))];
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
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
		private var zone:Array = new Array(sizeX);
		
		private var map:Dictionary = new Dictionary();
		

		public function Board()
		{
			//width = 600;
			//height = 600;
			opaqueBackground = "0xFFFFFF";
			map_tool = "grass";
			
			map.toString = function():String {
				var s:String = "";
				for (var key:Object in this) {
				   s += "{" + key.toString() + map[key].toString() + "}\n";
				}
				return s;
			}
			
			
			//The Zone
			zone.forEach(
			function (item:*, indexX:int, array:Array):void{
				item = new Array(sizeY);
				item.forEach(
				function (sector:*, indexY:int, array:Array):void {
					var location:Location = new Location(indexX, indexY);
					sector = new Sector("empty", location);
					sector.addEventListener(flash.events.Event.COMPLETE,function():void{
						//trace("sector.width" + sector.width);
						if (indexY % 2 == 0)
							sector.x = indexX * sector.contentWidth;
						else
							sector.x = indexX * sector.contentWidth + sector.contentWidth/2;
						
						sector.y = indexY/2 * sector.contentHeight*3/2;
						
					});
					sector.load("images/empty.png");
					addChild(sector);
					
					sector.addEventListener(flash.events.MouseEvent.MOUSE_MOVE, mouse_move);
					function mouse_move(event:MouseEvent):void
					{
						/*
						trace(event.bubbles);
						event.stopPropagation();
						trace(event.bubbles);
						*/
						if (event.buttonDown)
						{
							var x:int = event.currentTarget.location.x;
							var y:int = event.currentTarget.location.y;
							
							if (map_tool != "empty")
							{
								//if(map[new Location(x, y)] != null)
								//	map[new Location(x, y)].visible = false;
								//else
								//trace(map[new Location(x, y)]);
								//trace(map.toString());
								if (map[new Location(x, y)])
								{
									trace("found");
								}
								else
									trace("Not found at " + x + " " + y);
								//make_sectore(x, y, map_tool);
								
									
									
								//trace("making secotr of type" + map_tool);
							}
						}
						
					}
				});
			});
			
			//The map
			load_xml("maps/test.xml");
			
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
				
				make_sectore(x, y, type);
			}
		}
		
		private function make_sectore(x:int, y:int, type:String):void
		{
			var sector:Sector = new Sector(type);
			map[new Location(x, y)] = sector;
			
			sector.addEventListener(flash.events.Event.COMPLETE, function():void {
				if (y % 2 == 0)
					sector.x = x * sector.contentWidth;
				else
					sector.x = x * sector.contentWidth + sector.contentWidth/2;
				
				sector.y = y / 2 * sector.contentHeight * 3 / 2;
				//trace(x + " " + y);
				addChild(sector);
			});
			sector.load("images/" + type +".png");
		}
	}
}
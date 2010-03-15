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
	
	public class Board extends Canvas
	{
		private var map:Dictionary = new Dictionary();
		
		public function Board()
		{
			//xml
			load_xml("maps/test.xml");
			
			
			
			 
			
			
			//opaqueBackground = 0xFF0000;
			
			
			/*
			map.forEach(
			function (item:*, indexX:int, array:Array):void{
				item = new Array(sizeY);
				
				item.forEach(
				function (sector:*, indexY:int, array:Array):void{
					sector = new Sector();
					sector.addEventListener(flash.events.Event.COMPLETE,function():void{
						//trace("sector.width" + sector.width);
						if (indexY % 2 == 0)
							sector.x = indexX * sector.contentWidth;
						else
							sector.x = indexX * sector.contentWidth + sector.contentWidth/2;
						
						sector.y = indexY/2 * sector.contentHeight*3/2;
						
					});
					sector.load("images/grass.png");
					//sector.width = 80;
					//sector.height = 80;
					
					

					
					addChild(sector);
				});
			});
			*/
					
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
				trace(x + " " + y + " " + type);
				
				make_sectore(x, y, type);
				function make_sectore(x:int, y:int, type:String):void
				{
					var sector:Sector = new Sector(type);
					var location:Location = new Location(x, y);
					//map[location] = sector;
					
					sector.addEventListener(flash.events.Event.COMPLETE, function():void {
						if (y % 2 == 0)
							sector.x = x * sector.contentWidth;
						else
							sector.x = x * sector.contentWidth + sector.contentWidth/2;
						
						sector.y = y / 2 * sector.contentHeight * 3 / 2;
						trace(x + " " + y);
						addChild(sector);
					});
					sector.load("images/" + type +".png");
				}
				
			}
		}
	}
}
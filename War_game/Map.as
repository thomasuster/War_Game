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
	
	import War_game.Screen;
	import War_game.Location;
	import War_game.Hexagon_grid;
	import War_game.Sector_event;
	
	
	
	
	
	
	public class Map extends Sprite implements IHexagon_grid
	{	
		private var sizeX:int;
		private var sizeY:int;
		private var hexagon_grid:Hexagon_grid;
		private var map:Array;
		private var image_resource:Image_resource;
		
		public function Map(_sizeX:int, _sizeY:int, _image_resource:Image_resource):void
		{
			image_resource = _image_resource;
			hexagon_grid = new Hexagon_grid(_sizeX, _sizeY);
			sizeX = _sizeX;
			sizeY = _sizeY;
			map = hexagon_grid.grid;
		}
		public function map_toString():String
		{
			var s:String = "";
			var total:int = 0;
			/*
			for (var key:Object in map) {
				if(map[key].toString() != "empty")
				{
						s += "{" + key.toString() + " " + map[key].toString() + "}\n";
						total++;
				}
			}*/
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
				}
			}
			
		}
		
		public function export_map():XML 
		{
			var s:String = "<map>\n";
			
			for (var x:int = 0; x < sizeX; x++)
				for (var y:int = 0; y < sizeY; y++)
					if(map[x][y].type != "empty")
						s += "\t<s x='" + map[x][y].x + "' y='" + map[x][y].y + "'>" + map[x][y].type + "</s>\n";
			
			/*
			for (var key:Object in map) {
				if(map[key].type != "empty")
				   s += "\t<s x='" + key.x + "' y='" + key.y + "'>" + map[key].type + "</s>\n";
			}*/
			s += "</map>\n";
			var xml:XML = new XML(s);
			return xml;
		}
		
		private function make_sector(location:Location, type:String):void
		{
			//Init
			var sector:Sector = new Sector(image_resource.duplicate_image(type), location,type);
			map[location.x][location.y] = sector;
			
			//Map editing
			sector.addEventListener(MouseEvent.MOUSE_OVER, change_sector);
			sector.addEventListener(MouseEvent.MOUSE_DOWN, change_sector);
			function change_sector(event:MouseEvent):void
			{
				if (!event.buttonDown)
					return;
				
				dispatchEvent(new Sector_event(Sector(event.target), Sector_event.CLICKED, false, false));
				
			}
			this.addChild(sector);
		}		
		
		
		/**
		* Returns a Hash of available moves
		*/
		public function available_moves(location:Location, distance:int):Object 
		{
			var moves:Object = new Object();
			_available_moves(location, distance, moves);
			return moves;
		}
		
		/**
		* Helper function, Returns a Hash of available moves
		*/
		public function _available_moves(location:Location, distance:int, moves:Object):void 
		{	
			if (distance <= 0)
				return;
			
			moves[String(location)] = location;
			var circle:Array = get_circle(location, 1);
			for each (var l:Location in circle)
			{
				var dis:int = new int(distance-1);
				
				if (moves[String(l)] == null || true)
				{
					_available_moves(l, dis, moves);
				}
			}
			
		}
		
		public function get_circle(location:Location, r:int):Array
		{
			return hexagon_grid.get_circle(location, r);
		}
	}
}
package War_game
{
	import flash.sampler.NewObjectSample;
	import flash.ui.KeyLocation;
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
	
	import Math;
	
	import Standard.Image_resource;
	
	import War_game.Screen;
	import War_game.Location;
	import War_game.Hexagon_grid;
	import War_game.Sector_event;
	
	/**
	* The map
	*/
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
		
		/**
		* Loads the map xml file, calls load_map with files contents
		*/
		public function load_xml(xml_url:String):void 
		{
			var myXML:XML = new XML();
			var myXMLURL:URLRequest = new URLRequest(xml_url);
			var myLoader:URLLoader = new URLLoader(myXMLURL);
			myLoader.addEventListener("complete", xmlLoaded);
			function xmlLoaded(event:Event):void
			{
				myXML = XML(myLoader.data);
				load_map(myXML); //Decouple me
			}
		}
		
		/**
		* Loads the map from given xml
		*/
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
					
					if(original_map[indexX + " " + indexY] == undefined)
						make_sector(location, "empty");
					else
						make_sector(location, original_map[indexX + " " + indexY]);
				}
			}
			
		}
		
		/**
		* Returns XML of the current map
		*/
		public function export_map():XML 
		{
			var s:String = "<map>\n";
			
			for (var x:int = 0; x < sizeX; x++)
				for (var y:int = 0; y < sizeY; y++)
					if(map[x][y].get_name() != "empty")
						s += "\t<s x='" + x + "' y='" + y + "'>" + map[x][y].get_name() + "</s>\n";
						
			s += "</map>\n";
			var xml:XML = new XML(s);
			return xml;
		}
		
		/**
		* Makes a sector
		*/
		public function make_sector(location:Location, type:String):void
		{
			//remove
			if (map[location.x][location.y] != null)
			{
				removeChild(map[location.x][location.y]);
				delete map[location.x][location.y];
			}
			
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
			
			var location_moves:Object = new Object();
			for (var l:String in moves)
			{
				var a:Array = Location.un_pickle(l);
				location_moves[l] = new Location(a[0], a[1]);
			}
			return location_moves;
		}
		
		/**
		* Helper function, Returns a Hash of available moves
		*/
		public function _available_moves(location:Location, distance:int, moves:Object):void 
		{	
			if (distance < 0)
				return;
			
			//calc
			var sector:Sector = map[location.x][location.y];
			var difficulty:int = int(Sector.sector_stats[sector.get_name()]["infantry_moves"]);
			var new_distance:int = new int(distance-difficulty);
			
			//Special unmovable case
			if (difficulty == -1)
				return;
			
			moves[String(location)] = distance;
			
			var circle:Array = get_circle(location, 1);
			for each (var l:Location in circle)
			{
				if (moves[String(l)] == null)
				{
					_available_moves(l, new_distance, moves);
				}
				else if (moves[String(l)] != null && moves[String(l)] < new_distance)
				{
					delete moves[String(l)];
					_available_moves(l, new_distance, moves);
				}
			}
		}
	
		/**
		* Composition for Hexagon_grid
		*/
		public function distance(location_a:Location, location_b:Location):int {
			return hexagon_grid.distance(location_a, location_b);
		}
		public function get_circle(location:Location, r:int):Array {
			return hexagon_grid.get_circle(location, r);
		}
		public function get_sector(location:Location):Sector {
			return map[location.x][location.y];
		}
	}
}
package War_game
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.net.URLRequestHeader;
	import Standard.Image_resource;
	import War_game.Screen;
	import War_game.Location;
	import War_game.Hexagon_grid;
	import flash.display.BitmapData;
	import flash.utils.Dictionary;
	import Math;
	
	public class Screens extends Sprite implements IHexagon_grid
	{	
		private var hexagon_grid:Hexagon_grid;
		private var screens:Array;
		private var revealed:Object;
		private var image_resource:Image_resource;
		
		public function Screens(_sizeX:int, _sizeY:int, _image_resource:Image_resource):void
		{
			image_resource = _image_resource;
			revealed = new Object();
			hexagon_grid = new Hexagon_grid(_sizeX,_sizeY);
			screens = hexagon_grid.grid;
			this.visible = false;
		}
		
		public function populate():void 
		{
			//screen
			hexagon_grid.foreach(insert_screen);
			
			function insert_screen(l:Location):void
			{
				insert(image_resource.duplicate_image("screen"), l);
			}
			
		}
					
		public function get_circle(location:Location, r:int):Array
		{
			return hexagon_grid.get_circle(location, r);
		}
		
		
		public function insert(img:BitmapData, location:Location):void
		{
			var screen:Screen = new Screen(img, location);
			screens[location.x][location.y] = screen;
			this.addChild(screen);
		}
		
		public function is_revealed(location:Location):Boolean 
		{
			trace("(revealed[location] != null) = " + (revealed[location] != null));
			return (revealed[location] != null);
		}
		
		public function reveal(location:Location):void 
		{
			screens[location.x][location.y].reveal();
			revealed[location] = location;
		}
		public function conceal():void
		{
			for each (var l:Location in revealed)
			{
				screens[l.x][l.y].conceal();
				delete revealed[l];
			}
		}
		
		/*
		public function reveal_circle(location:Location, r:int):void 
		{
			conceal();
			//var c:Array;
			revealed = get_circle(location, r);
			
			for each (var l:Location in revealed)
				screens[l.x][l.y].reveal();
			
		}*/
	}
}
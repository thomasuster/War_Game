package War_game
{
	import adobe.utils.XMLUI;
	
	import mx.core.UIComponent;
	
	import flash.display.DisplayObject;
	import flash.filters.ConvolutionFilter;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.events.MouseEvent;
	import flash.display.Bitmap;
    import flash.display.BitmapData;
	
	import Standard.Image_resource;
	
	import War_game.Board_object;
	import War_game.Screens;
	import War_game.Sector;
	import War_game.Location;
	import War_game.Map;
	import War_game.Sector_event;
	
	
	
	
    

	public class Board extends UIComponent
	{
		//Zone
		private const sizeX:int = 23;
		private const sizeY:int = 20;
		
		public var mode:String;
		public var tool:String;
		public var radius:int;
		
		private var active_unit:Unit;
		private var screens:Screens;
		private var map:Map;
		private var units:Dictionary;
		private var image_resource:Image_resource;
		
		public function Board()
		{
			radius = 1;
			active_unit = null;
			opaqueBackground = "0xFFFFFF";
			tool = "grass";

			image_resource = new Image_resource("images.xml");
			map = new Map(sizeX, sizeY, image_resource);
			map.addEventListener(Sector_event.CLICKED, use_tool);
			screens = new Screens(sizeX, sizeY, image_resource);
			units = new Dictionary();
			
			image_resource.addEventListener("loaded", completeHandler);
			function completeHandler(event:Event):void
			{
				//The map
				map.load_xml("maps/river.xml");
				screens.populate();
			}
			this.addChild(map);
			this.addChild(screens);
		}
		
		public function export_map():XML 
		{
			return map.export_map();
		}
		
		private function use_tool(event:Sector_event):void
		{
			//trace("kar");
			var x:int = event.sector.location.x;
			var y:int = event.sector.location.y;
			
			switch (mode)
			{
				case "sector":
					if (tool != "empty")
					{
						map.make_sector(event.sector.location, tool);
						/*
						if (map[x][y] != null)
						{
							map[x][y].type = tool;
							map[x][y].image(image_resource.duplicate_image(tool));
						}
						else
							trace("Not found at " + x + " " + y);
						*/
					}
					break;
				case "unit":
					//make_unit(event.sector.location, tool);
					make_unit(event.sector.location, tool);
					break;
				case "move_unit":
					//trace("Moved to " + x + " " + y);
					//screens.visible = true;
					move_unit(event.sector.location);
					break;
			}
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
				screens.addEventListener(flash.events.MouseEvent.MOUSE_DOWN,hide);
				function hide(event:MouseEvent):void
				{
					screens.visible = false;
					screens.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, hide);
				}
				//int(Unit.stats["range"])
				//trace("radius = " + radius);
				var available_moves:Object = map.available_moves(active_unit.location, radius);
			
				screens.conceal();
				
				trace("bah");
				for each (var l:Location in available_moves)
					screens.reveal(l);
				trace("bang");
				
				
				//screens.reveal_circle(active_unit.location, radius);
				
			}
		}
		
		private function move_unit(location:Location):void
		{
			delete units[active_unit.location];
			active_unit.set_location(location);
			units[active_unit.location] = active_unit;
		}
	}
}

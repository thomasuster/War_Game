package War_game
{
	import adobe.utils.XMLUI;
	import flash.display.Sprite;
	
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
	import War_game.Units;
	import War_game.Sector_event;
	import War_game.Combat;
	
	
	
	
    

	public class Board extends UIComponent
	{
		//Zone
		private const sizeX:int = 23;
		private const sizeY:int = 20;
		
		public var mode:String;
		public var tool:String;
		public var radius:int;
		private var available_moves:Object;
		
		private var active_unit:Unit;
		private var screens:Screens;
		private var map:Map;
		private var units:Units;
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
			units = new Units(image_resource);
			units.addEventListener(Unit_event.CLICKED, select_unit);
			screens = new Screens(sizeX, sizeY, image_resource);
			
			image_resource.addEventListener("loaded", completeHandler);
			function completeHandler(event:Event):void
			{
				//The map
				map.load_xml("maps/river.xml");
				screens.populate();
			}
			this.addChild(map);
			this.addChild(units);
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
					units.make_unit(event.sector.location, tool);
					break;
				case "move_unit":
					//trace("Moved to " + x + " " + y);
					//screens.visible = true;
					if (active_unit != null && available_moves[event.sector.location] != null)
					{
						//trace("true");
						units.move_unit(active_unit, event.sector.location);
						show_moves(active_unit);
						show_in_range(active_unit);
						//active_unit.visible = true;
						//this.setChildIndex(units, 0);
						//screens.visible = true;
					}
					break;
			}
		}
		
		
		private function select_unit(event:Unit_event):void
		{
			var unit:Unit = event.unit;
			if (active_unit != null && screens.is_highlighted(unit.location))
			{
				trace("Initiate Combat");
				var combat:Combat = new Combat(active_unit, unit, image_resource);
				trace(map.distance(active_unit.location, unit.location));
				/*combat.engage(map.distance(active_unit.location, unit.location), 
					map[active_unit.location].get_attacking(), map[active_unit.location].get_defending(),
					map[unit.location].get_attacking(), map[unit.location].get_defending());
				*/
			}
			else
			{
				active_unit = unit;
				show_moves(unit);
				show_in_range(unit);
			}
		}
		
		private function show_moves(unit:Unit):void
		{
			mode = "move_unit"
			
			//Hide Screens on move
			screens.visible = true;
			screens.addEventListener(flash.events.MouseEvent.MOUSE_DOWN,hide);
			function hide(event:MouseEvent):void
			{
				screens.visible = false;
				active_unit = null;
				screens.removeEventListener(flash.events.MouseEvent.MOUSE_DOWN, hide);
			}
			
			//Calculate Moves
			available_moves = map.available_moves(active_unit.location, int(Unit.unit_stats[active_unit.unit_name]["moves"]));
			var a:Array = map.visual_test_distance(active_unit.location, 2);
				
			//Screen
			screens.conceal();
			//for each (var l:Location in available_moves)
				//screens.reveal(l);
				
				
			for each (var l:Location in a)
				screens.reveal(l);
		}
		
		private function show_in_range(unit:Unit):void
		{
			screens.un_highlight();
			
			//Get Circle
			var locations:Array = map.get_circle(unit.location, unit.get_range());
			
			//Remove me and all nulls
			var targets_locations:Array = locations.filter(function (loc:Location, index:int, arr:Array):Boolean {
				return (units.get_unit(loc) != null && units.get_unit(loc) != unit)
			});
			
			//For each Target
			for each(var l:Location in targets_locations)
			{
				var target:Unit = units.get_unit(l)
				
				screens.highlight(l);
				screens.reveal(l);
			}
		}
		
	}
}

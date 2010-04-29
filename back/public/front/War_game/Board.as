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
	import flash.net.URLVariables;
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
	import flash.external.ExternalInterface;
	import mx.controls.Alert;
	
	
	
    

	public class Board extends UIComponent
	{
		//Zone
		private const sizeX:int = 23;
		private const sizeY:int = 20;
		
		//Tools
		public var mode:String;
		public var tool:String;
		public var radius:int;
		private var available_moves:Object;
		public var color_mode:String;
		
		private var active_unit:Unit;
		private var screens:Screens;
		private var map:Map;
		private var units:Units;
		private var image_resource:Image_resource;
		private var game_guuid:String;
		
		public function Board()
		{
			//Get game_uuid from Javascript
			if (ExternalInterface.available)
			{
				try {
					game_guuid = ExternalInterface.call("get_param", "game_uuid");
					//Alert.show(a);
					//ExternalInterface.call("alert", a);
				} catch (error:SecurityError) {
					Alert.show("A SecurityError occurred: " + error.message + "\n");
                    
                } catch (error:Error) {
					Alert.show("An Error occurred: " + error.message + "\n");
                }
			}
			else
				Alert.show("Unavailable");
			
			//Alert.show("Breezed");
			//trace("here!!");
			
			radius = 1;
			active_unit = null;
			opaqueBackground = "0xFFFFFF";
			color_mode = "red";
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
				//Get a map
				
				//Prepare data
				var variables:URLVariables = new URLVariables();
				variables.game_uuid = game_guuid;
				
				for (var p:String in parentApplication.parameters)
				{
					Alert.show("param" + p, "Flash", 0, Sprite(parentApplication));
				}
				
				
				//Action
				var xml_url_request:URLRequest = new URLRequest("http://localhost:3000/front/get_map");
				xml_url_request.method = URLRequestMethod.GET;
				xml_url_request.data = variables;
					
				//Set Handlers and load
				var xml_send_loader:URLLoader = new URLLoader();
				xml_send_loader.addEventListener(Event.COMPLETE, on_complete, false, 0, true);
				xml_send_loader.addEventListener(IOErrorEvent.IO_ERROR, on_IO_error, false, 0, true);
				xml_send_loader.dataFormat = URLLoaderDataFormat.TEXT;
				xml_send_loader.load(xml_url_request);

				import flash.events.IOErrorEvent;
				import flash.net.URLRequestMethod;
				import flash.net.URLLoaderDataFormat;
				
				//Alert.show("I got here", "Flash", 0, Sprite(parentApplication));
				function on_complete(evt:Event):void
				{
					try {
						//Alert.show("I got here", "Flash", 0, Sprite(parentApplication));
						var loader:URLLoader = URLLoader(evt.target);
						//Alert.show("Then here", "Flash", 0, Sprite(parentApplication));
						var response:String = loader.data;
						//Alert.show("The response:\n" + response, "Flash",0, Sprite(parentApplication));
						//trace();
						map.load_map(XML(response));
						removeEventListener(Event.COMPLETE, on_complete);
						removeEventListener(IOErrorEvent.IO_ERROR, on_IO_error);
					} catch (err:TypeError) {
						Alert.show("An error occured when communicating with server:\n" + err.message, "Flash", 0, Sprite(parentApplication));
						trace("An error occured when communicating with server:\n" + err.message)
					}
				}

				function on_IO_error(evt:IOErrorEvent):void {
					trace("An error occurred when attempting to load the data.\n" + evt.text);
					Alert.show("An error occurred when attempting to load the data.\n" + evt.text, "Flash",0, Sprite(parentApplication));
					map.load_xml("maps/erin.xml");
				}
				
				
				
				
				//
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
		
		/**
		* Let's the user place sectors, units, or move units
		*/
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
					units.make_unit(event.sector.location, tool, color_mode);
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
		
		/**
		* Selects a unit, for moving/attacking
		*/
		private function select_unit(event:Unit_event):void
		{
			//init
			var unit:Unit = event.unit;
			
			//Combat
			if (active_unit != null && screens.is_highlighted(unit.location))
			{
				//Init
				var combat:Combat = new Combat(active_unit, unit, image_resource);
				var destroyed:Array = combat.engage();
				
				//Move this stuff to server
				//var attacker_terrain:Sector = map.get_sector(active_unit.location);
				//var defender_terrain:Sector = map.get_sector(unit.location);
				
				//Perform Combat
				/*
				var destroyed:Array = combat.engage(map.distance(active_unit.location, unit.location), 
					attacker_terrain.get_attacking(), attacker_terrain.get_defending(),
					defender_terrain.get_attacking(), defender_terrain.get_defending());*/
				
				//Show outcomes
				active_unit.refresh_number();
				unit.refresh_number();
				
				//Cleanup
				for each (var d:Unit in destroyed)
				{
					if (d == active_unit)
					{
						active_unit = null;
						screens.visible = false;
					}
					units.destroy_unit(d.location);
				}
			}
			else
			{
				//Set Active unit
				active_unit = unit;
			}
			
			if (active_unit != null)
			{
				//Show options
				show_moves(active_unit);
				show_in_range(active_unit);
			}
		}
		
		/**
		* Reveals secotors the unit is able to move to
		*/
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
			
			//Screen
			screens.conceal();
			for each (var l:Location in available_moves)
				screens.reveal(l);
		}
		
		/**
		* Reveals and outlines the units the selected unit is able to attack
		*/
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

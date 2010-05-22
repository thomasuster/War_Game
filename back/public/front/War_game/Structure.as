package War_game
{	
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import War_game.Colored;
	import War_game.Stats;
	
	import Standard.Module_event;
	
	import mx.events.ModuleEvent;
	import mx.modules.ModuleManager;
	import mx.modules.IModuleInfo;
	import mx.modules.Module;
	import mx.managers.PopUpManager;
	
	import mx.controls.Alert;
	
	public class Structure extends Colored
	{
		//Static Stats, Maybe later
		/*[Embed(source = "/stats/units.xml", mimeType="application/octet-stream")]
		private static const stats_xml:Class;
		public static var stats:Stats;
		public static var unit_stats:Object;*/
		
		public var structure_name:String;
		
		public var module_info:IModuleInfo;
		
		public function Structure(_structure_name:String="empty", _color:String="red", new_bitmapData:BitmapData = null, new_location:Location=null):void
		{
			super(_color, new_bitmapData, new_location);
			structure_name = _structure_name;
			
			this.addEventListener(MouseEvent.CLICK, buy_click);
			
			/* Maybe later
			//Static Stats
			if (stats == null)
			{
				stats = new Stats(stats_xml);
				unit_stats = stats.hash;
			}*/
		}
		
		public function get_name():String { return structure_name; }
		
		public override function toString():String
		{
			return structure_name;
		}
		
		/**
		* Loads export_map module
		*/
		private function buy_click(event:MouseEvent):void 
		{
			import flash.system.SecurityDomain;
			
			module_info = ModuleManager.getModule("buy.swf");
			module_info.addEventListener(ModuleEvent.READY, show_buy);
			module_info.addEventListener(ModuleEvent.ERROR, buy_error);
			module_info.load();
			
			function buy_error(e:ModuleEvent):void {
				Alert.show("Error: " + e.errorText);
			}
		}

		/**
		* Popups export_map module
		*/
		private function show_buy(e:ModuleEvent):void
		{
			var prompt:Module = module_info.factory.create() as Module;
			prompt.addEventListener(Module_event.COMPLETE, function():void {
				PopUpManager.removePopUp(prompt);
			});
			
			PopUpManager.addPopUp(prompt, this, true);
			PopUpManager.centerPopUp(prompt);
		}
	}
}
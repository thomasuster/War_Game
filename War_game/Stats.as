package War_game
{
	import War_game.IStats;
	
	public class Stats
	{
		public var hash:Object;
		
		public function Stats(type:Class):void
		{
			hash = new Object();
			var x:XML = XML(new type());
			process_xml(x);
			
		}
		
		/**
		 * populates a hash of a hash for getting stats
		 * @param	xml
		 */
		private function process_xml(xml:XML):void
		{
			for each (var row:XML in xml.*)
			{
				var name:String;
				for each(var a:XML in row.@*)
				{
					if (String(a.name()) == "name")
					{
						name = String(a.toXMLString());
						hash[name] = new Object();
						//trace(name);
					}
					else
					{
						hash[name][String(a.name())] = String(a.toXMLString());
						//trace(String(a.name()) + " -> " + String(a.toXMLString()));
					}
				}
				
			}
		}
	}
}
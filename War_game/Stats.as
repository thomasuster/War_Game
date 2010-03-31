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
		
		private function process_xml(xml:XML):void
		{
			for each (var unit:XML in xml.*)
			{
				for each(var a:XML in unit.@*)
				{
					hash[String(a.name())] = String(a.toXMLString());
				}
				
			}
		}
	}
}
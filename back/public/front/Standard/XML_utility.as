package Standard
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLRequest;
	import flash.events.*;
    import flash.net.*;
	
	
	public class XML_utility extends EventDispatcher
	{
		public var myXML:XML;
		public var myXMLURL:URLRequest;
		public var myLoader:URLLoader;
		public function load_xml(xml_url:String):void 
		{
			myXML = new XML();
			myXMLURL = new URLRequest(xml_url);
			myLoader = new URLLoader(myXMLURL);
			myLoader.addEventListener("complete", xmlLoaded);
			function xmlLoaded(event:Event):void
			{
				myXML = XML(myLoader.data);
				//trace("Data loaded.");
				dispatchEvent(new Event("loaded"));
			}
		}
	}
}
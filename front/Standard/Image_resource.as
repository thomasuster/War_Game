package Standard
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.events.*;
    import flash.net.URLRequest;
	import flash.events.Event;
	import Standard.XML_utility;

    public class Image_resource extends EventDispatcher
	{
		private var images_file:String;
		private var number_loaded:int;
		private var number_to_load:int;
		private var images:Object = new Object();

        public function Image_resource(new_images_file:String)
		{
			images_file = new_images_file;
			number_loaded = 0;
			number_to_load = 0;
			
			//XML
			var xml_utility:XML_utility = new XML_utility();
			xml_utility.addEventListener("loaded", function ():void {
				process_xml(xml_utility.myXML)});
			xml_utility.load_xml(images_file);
        }
		
		public function process_xml(xml:XML):void 
		{
			for each (var directory:XML in xml.directory)
			{
				var url:String = String(directory.@url);
				for each (var i:XML in directory.i)
				{
					var name:String = String(i.@name);
					images[name] = url + i;
					trace(images[name]);
					number_to_load++;
				}
			}
			
			for (var image:Object in images)
			{
				load_image(String(image), images[image]);
			}
		}

        public function load_image(key:String, url:String):void
		{
			//trace("Trying to load " + url)
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            var request:URLRequest = new URLRequest(url);
			loader.load(request);
			
			function completeHandler(event:Event):void
			{
				var loader:Loader = Loader(event.target.loader);
				var image:Bitmap = Bitmap(loader.content);
				
				//trace("loaded " + key + " to Image Resouce");
				number_loaded++;
				
				images[key] = image;
				
				if(number_loaded == number_to_load)
					dispatchEvent(new Event("loaded"));
			}
        }
		
		public function has_image(key:String):Boolean
		{
			return (images[key] != null);
		}

        public function duplicate_image(key:String):BitmapData
		{
            //var image:Bitmap = new Bitmap(original.bitmapData.clone());
            return images[key].bitmapData;
        }

        private function ioErrorHandler(event:IOErrorEvent):void {
            trace("Unable to load image");
        }
    }
}
package Standard
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Loader;
    import flash.events.*;
    import flash.net.URLRequest;
	import flash.events.Event

    public class Image_resource extends EventDispatcher
	{
		private var number_to_load:int;
		private var number_loaded:int;
		private var images:Object = new Object();

        public function Image_resource(new_number_to_load:int)
		{
			number_loaded = 0;
			number_to_load = new_number_to_load;
        }

        public function load_image(key:String, url:String):void
		{
            var loader:Loader = new Loader();
            loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
            loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            var request:URLRequest = new URLRequest(url);
			loader.load(request);
			
			function completeHandler(event:Event):void
			{
				var loader:Loader = Loader(event.target.loader);
				var image:Bitmap = Bitmap(loader.content);
				images[key] = image;
				trace("loaded " + key + " to Image Resouce");
				number_loaded++;
				
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
package Standard
{
	import flash.events.IOErrorEvent;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.events.HTTPStatusEvent;
	import flash.events.EventDispatcher;
	import mx.controls.Alert;
	
	/**
	* HTTP Request handler
	*/
	public class Request extends EventDispatcher
	{
		private var response:String;
		private var xml_send_loader:URLLoader;
		private var xml_url_request:URLRequest;
		
		public function Request(_variables:Object, url:String, method:String):void
		{
			//Prepare data
			var variables:URLVariables = new URLVariables();
			for(var name:String in _variables)
				variables[name] = _variables[name];
			
			//Action
			xml_url_request = new URLRequest(url);
			xml_url_request.method = method;
			xml_url_request.data = variables;
				
			//Set Handlers
			xml_send_loader = new URLLoader();
			xml_send_loader.addEventListener(Event.COMPLETE, on_complete, false, 0, true);
			xml_send_loader.addEventListener(IOErrorEvent.IO_ERROR, on_IO_error, false, 0, true);
			xml_send_loader.addEventListener(Event.OPEN, open_handler);
			xml_send_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, http_status_handler);
			xml_send_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, security_error_handler);	
			xml_send_loader.addEventListener(ProgressEvent.PROGRESS, progress_handler);
			xml_send_loader.dataFormat = URLLoaderDataFormat.TEXT;

			function open_handler(event:Event):void {
				trace("open_handler: " + event);
				//Alert.show("open_handler: " + event, "Flash",0, Sprite(parentApplication));
			}

			function progress_handler(event:ProgressEvent):void {
				trace("progress_handler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
				//Alert.show("progress_handler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal,"Flash", 0, Sprite(parentApplication));
			}

			function security_error_handler(event:SecurityErrorEvent):void {
				trace("security_error_handler: " + event);
				//Alert.show("security_error_handler: " + event, "Flash",0, Sprite(parentApplication));
			}

			function http_status_handler(event:HTTPStatusEvent):void {
				trace("http_status_handler: " + event);
				//Alert.show("http_status_handler: " + event, "Flash",0, Sprite(parentApplication));
			}

			function on_complete(evt:Event):void
			{
				try {
					var loader:URLLoader = URLLoader(evt.target);
					response = loader.data;
					//Alert.show("Response:\n" + response);
					trace("Response:\n" + response);
					removeEventListener(Event.COMPLETE, on_complete);
					removeEventListener(IOErrorEvent.IO_ERROR, on_IO_error);
					dispatchEvent(new Event("complete", false, false));
				} catch (err:TypeError) {
					Alert.show("An error occured when communicating with server:\n" + err.message);
					trace("An error occured when communicating with server:\n" + err.message)
				}
			}

			function on_IO_error(evt:IOErrorEvent):void {
				trace("An error occurred when attempting to load the XML.\n" + evt.text);
				Alert.show("An error occurred when attempting to load the XML.\n" + evt.text);
			}
		}
		
		public function load():void
		{
			//Load
			xml_send_loader.load(xml_url_request);
		}
		
		public function get_response():String
		{
			return response;
		}
	}
}
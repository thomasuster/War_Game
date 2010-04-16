import flash.events.MouseEvent;
import mx.events.MenuEvent;
import mx.collections.*;
import mx.managers.CursorManager;
import flash.utils.getDefinitionByName;

[Bindable]
public var game_collection:XMLListCollection;
private var game_menu:XMLList =
	<>
		<menuitem label="Game Menu" data="top">
			<menuitem label="Skip the Animations" data=""/>
			<menuitem label="Skip Confirmations" data=""/>
			<menuitem label="Surrender" data=""/>
			<menuitem label="Emails" data=""/>
		</menuitem>
	</>;

[Bindable]
public var map_collection:XMLListCollection;
private var map_menu:XMLList =
	<>
		<menuitem label="Map Menu" data="top">
			<menuitem label="Grass" data="grass"/>
			<menuitem label="Forest" data="forest"/>
			<menuitem label="Hills" data="hill"/>
			<menuitem label="Mountain" data="mountain"/>
			<menuitem label="Water" data="water"/>
		</menuitem>
	</>;
	
[Bindable]
public var color_collection:XMLListCollection;
private var color_menu:XMLList =
	<>
		<menuitem label="Color Menu" data="top">
			<menuitem label="Red" data="red"/>
			<menuitem label="Green" data="green"/>
			<menuitem label="Blue" data="blue"/>
			<menuitem label="Yellow" data="yellow"/>
			<menuitem label="Teal" data="teal"/>
			<menuitem label="Pink" data="pink"/>
			<menuitem label="Orange" data="orange"/>
			<menuitem label="Purple" data="purple"/>
		</menuitem>
	</>;
	
[Bindable]
public var infantry_collection:XMLListCollection;
private var infantry_menu:XMLList =
	<>
		<menuitem label="infantry Menu" data="top">
			<menuitem label="Engineer" data="engineer"/>
			<menuitem label="Infantry" data="infantry"/>
			<menuitem label="MG Team" data="mg_team"/>
			<menuitem label="Morter Team" data="morter_team"/>
			<menuitem label="AT Team" data="at_team"/>
			<menuitem label="Officer" data="officer"/>
			<menuitem label="Special Forces" data="special_forces"/>
			<menuitem label="Sniper" data="sniper"/>
		</menuitem>
	</>;
	
[Bindable]
public var vehicle_collection:XMLListCollection;
private var vehicle_menu:XMLList =
	<>
		<menuitem label="Vehicle Menu" data="top">
			<menuitem label="Light Tank" data="light_tank"/>
			<menuitem label="Halftrack" data="halftrack"/>
			<menuitem label="Jeep" data="jeep"/>
			<menuitem label="Tank" data="tank"/>
			<menuitem label="Artillary" data="artillary"/>
		</menuitem>
	</>;

[Bindable]
public var temp_collection:XMLListCollection;
private var temp_menu:XMLList =
	<>
		<menuitem label="Temp Menu" data="top">
			<menuitem label="1" data="1"/>
			<menuitem label="2" data="2"/>
			<menuitem label="3" data="3"/>
			<menuitem label="4" data="4"/>
			<menuitem label="5" data="5"/>
			<menuitem label="6" data="6"/>
			<menuitem label="7" data="7"/>
			<menuitem label="8" data="8"/>
		</menuitem>
	</>;


/*	
[Embed(source="images/sectors/grass.png")]
[Bindable]
public var grass:Class;

[Embed(source="images/sectors/forest.png")]
[Bindable]
public var forest:Class;

[Embed(source="images/sectors/hill.png")]
[Bindable]
public var hill:Class;

[Embed(source="images/sectors/mountain.png")]
[Bindable]
public var mountain:Class;

[Embed(source="images/sectors/water.png")]
[Bindable]
public var water:Class;
*/

// Event handler to initialize the MenuBar control.
private function initCollections():void {
	game_collection = new XMLListCollection(game_menu);
	map_collection = new XMLListCollection(map_menu);
	color_collection = new XMLListCollection(color_menu);
	infantry_collection = new XMLListCollection(infantry_menu);
	vehicle_collection = new XMLListCollection(vehicle_menu);
	temp_collection = new XMLListCollection(temp_menu);
}

// Event handler for the MenuBar control's itemClick event.
private function menuHandler(event:MenuEvent):void 
{
	//trace(event.item.@data);
	var s:String = event.item.@data;
	//CursorManager.removeAllCursors();
	//var ClassReference:Class = getDefinitionByName("grass") as Class;
	//CursorManager.setCursor(this[s]);
	board.mode = "sector";
	board.tool = s;
	//CursorManager.setCursor(eval(event.item));
}

private function color_menu_Handler(event:MenuEvent):void 
{
	var s:String = event.item.@data;
	board.color_mode = s;
}

// Event handler for the infantry_menu control's itemClick event.
private function unit_menu_Handler(event:MenuEvent):void 
{
	var s:String = event.item.@data;
	board.mode = "unit";
	board.tool = s;
	board.tool
}

// Event handler for the unit_menu control's itemClick event.
private function temp_menu_Handler(event:MenuEvent):void 
{
	board.radius = int(event.item.@data);
}

private function end_turn(event:MouseEvent):void 
{
	
}

private function export_map(event:MouseEvent):void 
{
	import mx.controls.Alert;
    import mx.events.CloseEvent;
			
	//trace(board.export_map().toString());
	//Alert.show(board.export_map().toString(), "Flash", 0, this);

			
	//Technique from sgrant at http://www.actionscript.org/forums/showthread.php3?t=169554
	var xml_string:String = board.export_map().toString();
	//var map:XML = new XML(xml_string);
	var xml_url_request:URLRequest = new URLRequest("http://localhost:3000/front/save");
	
	xml_url_request.data = xml_string;
	//Alert.show(xml_string, "Flash");
	xml_url_request.contentType = "text/xml";
	xml_url_request.method = URLRequestMethod.POST;
	
	var xml_send_loader:URLLoader = new URLLoader();
	xml_send_loader.addEventListener(Event.COMPLETE, on_complete, false, 0, true);
	xml_send_loader.addEventListener(IOErrorEvent.IO_ERROR, on_IO_error, false, 0, true);
	
	xml_send_loader.addEventListener(Event.OPEN, openHandler);
	xml_send_loader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
	xml_send_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);	
	xml_send_loader.addEventListener(ProgressEvent.PROGRESS, progressHandler);
	xml_send_loader.dataFormat=URLLoaderDataFormat.BINARY;
	
	
	
	xml_send_loader.load(xml_url_request);

	
	function openHandler(event:Event):void {
		trace("openHandler: " + event);
	}

	function progressHandler(event:ProgressEvent):void {
		trace("progressHandler loaded:" + event.bytesLoaded + " total: " + event.bytesTotal);
	}

	function securityErrorHandler(event:SecurityErrorEvent):void {
		trace("securityErrorHandler: " + event);
	}

	function httpStatusHandler(event:HTTPStatusEvent):void {
		trace("httpStatusHandler: " + event);
	}

		
	function on_complete(evt:Event):void
	{
		try {
			//var xml_response:XML = new XML(evt.target.data);
			//Alert.show(xml_response.toString(), "Flash", 0, this);
			var loader:URLLoader = URLLoader(evt.target);
			var response:String = loader.data;
			Alert.show(response, "Flash");
			trace(response);
			removeEventListener(Event.COMPLETE, on_complete);
			removeEventListener(IOErrorEvent.IO_ERROR, on_IO_error);
		} catch (err:TypeError) {
			Alert.show("An error occured when communicating with server:\n" + err.message, "Flash", 0, this);
		}
	}

	function on_IO_error(evt:IOErrorEvent):void {
		Alert.show("An error occurred when attempting to load the XML.\n" + evt.text, "Flash", 0, this);
	}
}

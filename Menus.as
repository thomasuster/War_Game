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
public var unit_collection:XMLListCollection;
private var unit_menu:XMLList =
	<>
		<menuitem label="Unit Menu" data="top">
			<menuitem label="Engineer" data="engineer"/>
			<menuitem label="Infantry" data="infantry"/>
			<menuitem label="MG Team" data="mg_team"/>
			<menuitem label="Morter Team" data="morter_team"/>
			<menuitem label="AT Team" data="at_team"/>
			<menuitem label="Officer" data="officer"/>
			<menuitem label="Special Forces" data="special_forces"/>
		</menuitem>
	</>;
	


	
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

// Event handler to initialize the MenuBar control.
private function initCollections():void {
	game_collection = new XMLListCollection(game_menu);
	map_collection = new XMLListCollection(map_menu);
	unit_collection = new XMLListCollection(unit_menu);
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

// Event handler for the unit_menu control's itemClick event.
private function unit_menu_Handler(event:MenuEvent):void 
{
	var s:String = event.item.@data;
	board.mode = "unit";
	board.tool = s;
	trace("working");
	
}

private function end_turn(event:MouseEvent):void 
{
	
}

private function export_map(event:MouseEvent):void 
{
	trace(board.export_map().toString());
}

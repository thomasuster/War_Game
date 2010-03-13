import mx.events.MenuEvent;
import mx.collections.*;

[Bindable]
public var menuBarCollection:XMLListCollection;

private var menubarXML:XMLList =
	<>
		<menuitem label="Settings" data="top">
			<menuitem label="Skip the Animations" data=""/>
			<menuitem label="Skip Confirmations" data=""/>
			<menuitem label="Surrender" data=""/>
			<menuitem label="Emails" data=""/>
		</menuitem>
	</>;

// Event handler to initialize the MenuBar control.
private function initCollections():void {
	menuBarCollection = new XMLListCollection(menubarXML);
}

// Event handler for the MenuBar control's itemClick event.
private function menuHandler(event:MenuEvent):void  {
}
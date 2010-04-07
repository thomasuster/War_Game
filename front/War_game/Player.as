import flash.display.Sprite;
import flash.events.MouseEvent;

var circle1:Sprite = new Sprite();
circle1.graphics.beginFill(0xFFCC00);
circle1.graphics.drawCircle(40, 40, 40);
circle1.buttonMode = true;
circle1.addEventListener(MouseEvent.CLICK, clicked);

var circle2:Sprite = new Sprite();
circle2.graphics.beginFill(0xFFCC00);
circle2.graphics.drawCircle(120, 40, 40);
circle2.buttonMode = false;
circle2.addEventListener(MouseEvent.CLICK, clicked);

function clicked(event:MouseEvent):void {
    trace ("Click!");
}

addChild(circle1);
addChild(circle2);
package War_game
{
	import mx.containers.Canvas;
	import War_game.Sector;
	import mx.events.FlexEvent;
	public class Board extends Canvas
	{
		private const sizeX:int = 10;
		private const sizeY:int = 10;
		private var map:Array = new Array(sizeX);
		
		public function Board()
		{
			//opaqueBackground = 0xFF0000;
			
			
			map.forEach(
			function (item:*, indexX:int, array:Array):void{
				item = new Array(sizeY);
				
				item.forEach(
				function (sector:*, indexY:int, array:Array):void{
					sector = new Sector();
					sector.load("images/grass.png");
					//sector.width = 80;
					//sector.height = 80;
					trace("blar");
					sector.addEventListener(mx.events.FlexEvent.DATA_CHANGE,function():void{
						this.x = indexX * 40;//sector.width;
						this.y = indexY * 40;//sector.height;
						
					});

					
					addChild(sector);
				});
				
				
				
				
			});
					
		}
	}
}
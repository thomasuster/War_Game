package War_game
{
	import flash.utils.Dictionary;
	import War_game.Board_object;
	import flash.display.BitmapData;
	import flash.geom.Transform;
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	import flash.display.Sprite;
	
	public class Screen extends Board_object
	{
		public function Screen(new_bitmapData:BitmapData = null, new_location:Location=null):void
		{
			super(new_bitmapData, new_location);
			
			var resultColorTransform:ColorTransform = new ColorTransform();
			resultColorTransform.alphaMultiplier = 0.5;
			resultColorTransform.redMultiplier = 0.0;
			resultColorTransform.greenMultiplier = 0.0;
			resultColorTransform.blueMultiplier = 0.0;
			
			bitmap.transform.colorTransform = resultColorTransform;
		}
		
		public function stroke():void
		{
			var line:Sprite = new Sprite();
			line.graphics.lineStyle(2, 0x990000, .75);
			line.graphics.moveTo(0, sector_height / 4);
			line.graphics.lineTo(sector_width / 2, 0);
			line.graphics.lineTo(sector_width, sector_height / 4);
			
			line.graphics.lineTo(sector_width, 3 * sector_height / 4);
			line.graphics.lineTo(sector_width / 2, sector_height);
			line.graphics.lineTo(0, 3 * sector_height / 4);
			line.graphics.lineTo(0, sector_height / 4);
			
			this.addChild(line);
		}
		
		public function reveal():void
		{
			var resultColorTransform:ColorTransform = new ColorTransform();
			resultColorTransform.alphaMultiplier = 0.0;
			resultColorTransform.redMultiplier = 0.0;
			resultColorTransform.greenMultiplier = 0.0;
			resultColorTransform.blueMultiplier = 0.0;
			
			bitmap.transform.colorTransform = resultColorTransform;
		}
		
		public function conceal():void
		{
			var resultColorTransform:ColorTransform = new ColorTransform();
			resultColorTransform.alphaMultiplier = 0.5;
			resultColorTransform.redMultiplier = 0.0;
			resultColorTransform.greenMultiplier = 0.0;
			resultColorTransform.blueMultiplier = 0.0;
			
			bitmap.transform.colorTransform = resultColorTransform;
		}
	}
}
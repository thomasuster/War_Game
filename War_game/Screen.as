package War_game
{
	import flash.utils.Dictionary;
	import War_game.Board_object;
	import flash.display.BitmapData;
	import flash.geom.Transform;
	import flash.geom.Matrix;
	import flash.geom.ColorTransform;
	
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
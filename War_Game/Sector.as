package War_game
{
	import mx.controls.Image; 
	public class Sector extends Image
	{
		private var type:String;
		
		public function Sector(new_type:String="grass"):void
		{
			type = new_type;
		}
	}
}
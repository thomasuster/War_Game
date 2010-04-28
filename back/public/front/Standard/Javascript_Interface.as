package Standard
{
	import Math;
	
	public class Javascript_interface 
	{
		public static function rgb_color(rgb:Number, color:String):Number
		{
			switch(color)
			{
				case "red":
					return rgb >> 16;
				case "green":
					return (rgb ^ rgb >> 16 << 16) >> 8;
				case "blue":
					return rgb >> 8 << 8 ^ rgb;
			}
			return -1;
		}
		/*
		public static function to_hex_string(decimal:int):String
		{
			var r:int = decimal % 16;
			var result:String;
			if (decimal-r == 0) 
				result = single_dec_to_hex(r);
			else 
				result = single_dec_to_hex( Math.floor((decimal-r)/16) ) + single_dec_to_hex(r);
			return result;
		}
		
		private static function single_dec_to_hex(n:int):String
		{
			const hex:String = "0123456789ABCDEF";
			return hex.charAt(n);
		}*/
	}
}
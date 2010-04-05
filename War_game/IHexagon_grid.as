package War_game
{
	public interface IHexagon_grid
	{
		function get_circle(location:Location, r:int):Array;
		function distance(location_a:Location, location_b:Location):int
	}	
}
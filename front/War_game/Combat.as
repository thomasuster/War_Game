package War_game
{
	import flash.display.Sprite;
	import Standard.Image_resource;
	import War_game.Unit;
	import War_game.Weapon;
	import Math;
	
	public class Combat extends Sprite
	{	
		private var image_resource:Image_resource;
		private var attacker:Unit;
		private var defender:Unit;
		
		public function Combat(_attacker:Unit, _defender:Unit, _image_resource:Image_resource):void
		{
			image_resource = _image_resource;
			attacker = _attacker;
			defender = _defender;
		}
		
		/**
		 * Returns Array of units destroyed
		 * @param	range
		 * @param	attacker_mult_damage
		 * @param	attacker_mult_defense
		 * @param	defender_mult_damage
		 * @param	defender_mult_defense
		 * @return
		 */
		public function engage(range:int, 
		attacker_mult_damage:int, attacker_mult_defense:int,
		defender_mult_damage:int, defender_mult_defense:int):Array
		{
			var destroyed:Array = new Array();
			var a_damage:int = damage(attacker, range, attacker_mult_damage);
			//trace("Attacker did " + String(a_damage) + " damage" );
			var d_damage:int = damage(defender, range, attacker_mult_damage);
			//trace("Defender did " + String(d_damage) + " damage" );
			var a_defense:int = defense(attacker, attacker_mult_defense);
			var d_defense:int = defense(defender, defender_mult_defense);
			
			if (a_damage-d_defense > 0)
			{
				defender.number -= a_damage-d_defense;
				if (defender.number <= 0)
					destroyed.push(defender);
			}
				
			if (d_damage-a_defense > 0)
			{
				attacker.number -= d_damage-a_defense;
				if (attacker.number <= 0)
					destroyed.push(attacker);
			}
			
			//trace("Attacker did " + String(a_damage-d_defense) + " net damage" );
			//trace("Defender did " + String(d_damage-a_defense) + " net damage" );
			return destroyed;
			
		}
		
		private function damage(unit:Unit, range:int, attack_multiplier:int):int
		{
			var weapon:Weapon = new Weapon(unit.get_weapon());
			if (range > unit.get_range())
				return 0;
			else 	
				//return (unit.get_number() * attack_multiplier) * 1/(Math.abs(range - unit.get_optimum_range())+1) * (weapon.get_power() * weapon.get_number());
				return unit.get_number();
		}
		
		private function defense(unit:Unit, defense_multiplier:int):int
		{
			return (unit.get_number() * defense_multiplier);
		}
	}
}
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
		
		public function Combat(_attacker:int, _defender:Unit, _image_resource:Image_resource):void
		{
			image_resource = _image_resource;
			attacker = _attacker;
			defender = _defender;
		}
		
		public function engage(range, 
		attacker_mult_damage, attacker_mult_defense
		defender_mult_damage, defender_mult_defense):void
		{
			a_damage = damage(attacker, range, attacker_mult_damage);
			d_damage = damage(defender, range, attacker_mult_damage);
			a_defense = defense(attacker, attacker_mult_defense);
			d_defense = defense(defender, defender_mult_defense);
			if(a_damage-d_defense > 0)
				defender.number -= a_damage-d_defense;
			if(d_damage-a_defense > 0)
				attacker.number -= d_damage-a_defense;
		}
		
		private function damage(unit:Unit, range:int, attack_multiplier:int):void
		{
			var weapon:Weapon = new Weapon(unit.weapon);
			return (unit.number * attack_multiplier) * Math.abs(range - unit.optimum_range) * (weapon.power * weapon.number);
		}
		
		private function damage(unit:Unit, defense_multiplier:int):void
		{
			return (unit.number * defense_multiplier);
		}
	}
}